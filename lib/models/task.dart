import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  factory Task.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? const <String, dynamic>{};

    return Task(
      id: document.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      completed: data['completed'] as bool? ?? false,
    );
  }

  final String id;
  final String title;
  final String description;
  final bool completed;
}
