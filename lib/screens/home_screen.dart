import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';

import '../models/task.dart';
import 'task_form_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSigningOut = false;
  bool _isUpdating = false;

  User get _user => FirebaseAuth.instance.currentUser!;

  CollectionReference<Map<String, dynamic>> get _tasks => FirebaseFirestore
      .instance
      .collection('users')
      .doc(_user.uid)
      .collection('tasks');

  Future<void> _signOut() async {
    setState(() => _isSigningOut = true);

    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {
      if (mounted) {
        _showError('No se pudo cerrar la sesión. Inténtalo de nuevo.');
        setState(() => _isSigningOut = false);
      }
    }
  }

  Future<void> _openTaskForm([Task? task]) async {
    final result = await showDialog<TaskFormResult>(
      context: context,
      builder: (_) => TaskFormDialog(task: task),
    );

    if (result == null || !mounted) return;

    await _runUpdate(
      () async {
        if (task == null) {
          await _tasks.add({
            'title': result.title,
            'description': result.description,
            'completed': false,
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        } else {
          await _tasks.doc(task.id).update({
            'title': result.title,
            'description': result.description,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }
      },
      task == null
          ? 'No se pudo crear la tarea.'
          : 'No se pudo editar la tarea.',
    );
  }

  Future<void> _toggleTask(Task task, bool? completed) async {
    if (completed == null) return;

    await _runUpdate(
      () => _tasks.doc(task.id).update({
        'completed': completed,
        'updatedAt': FieldValue.serverTimestamp(),
      }),
      'No se pudo actualizar la tarea.',
    );
  }

  Future<void> _confirmDelete(Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar tarea'),
        content: Text('¿Deseas eliminar "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    await _runUpdate(
      () => _tasks.doc(task.id).delete(),
      'No se pudo eliminar la tarea.',
    );
  }

  Future<void> _runUpdate(
    Future<void> Function() operation,
    String errorMessage,
  ) async {
    setState(() => _isUpdating = true);

    try {
      await operation();
    } catch (_) {
      if (mounted) _showError('$errorMessage Inténtalo de nuevo.');
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas'),
        actions: [
          IconButton(
            onPressed: _isSigningOut ? null : _signOut,
            tooltip: 'Cerrar sesión',
            icon: _isSigningOut
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.logout),
          ),
          const SizedBox(width: 8),
        ],
        bottom: _isUpdating
            ? const PreferredSize(
                preferredSize: Size.fromHeight(3),
                child: LinearProgressIndicator(),
              )
            : null,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _tasks.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _TaskErrorState(onRetry: () => setState(() {}));
          }

          final tasks =
              snapshot.data?.docs.map(Task.fromDocument).toList() ?? [];

          if (tasks.isEmpty) return const _EmptyTaskState();

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                itemCount: tasks.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: task.completed,
                        onChanged: _isUpdating
                            ? null
                            : (value) => _toggleTask(task, value),
                      ),
                      title: Text(
                        task.title,
                        style: task.completed
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough,
                              )
                            : null,
                      ),
                      subtitle: task.description.isEmpty
                          ? Text(task.completed ? 'Completada' : 'Pendiente')
                          : Text(task.description),
                      isThreeLine: task.description.isNotEmpty,
                      trailing: PopupMenuButton<_TaskAction>(
                        enabled: !_isUpdating,
                        onSelected: (action) {
                          switch (action) {
                            case _TaskAction.edit:
                              _openTaskForm(task);
                            case _TaskAction.delete:
                              _confirmDelete(task);
                          }
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: _TaskAction.edit,
                            child: ListTile(
                              leading: Icon(Icons.edit_outlined),
                              title: Text('Editar'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          PopupMenuItem(
                            value: _TaskAction.delete,
                            child: ListTile(
                              leading: Icon(Icons.delete_outline),
                              title: Text('Eliminar'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isUpdating ? null : _openTaskForm,
        icon: const Icon(Icons.add),
        label: const Text('Nueva tarea'),
      ),
    );
  }
}

enum _TaskAction { edit, delete }

class _EmptyTaskState extends StatelessWidget {
  const _EmptyTaskState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.task_alt,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Aún no tienes tareas',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Crea tu primera tarea para comenzar.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskErrorState extends StatelessWidget {
  const _TaskErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            const Text(
              'No se pudieron cargar las tareas.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
