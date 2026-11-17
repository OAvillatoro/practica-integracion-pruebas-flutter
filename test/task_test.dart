import 'package:flutter_test/flutter_test.dart';
import 'package:practica_integracion_pruebas_flutter/models/task.dart';

void main() {
  test('Task conserva sus datos y estado de finalización', () {
    const task = Task(
      id: 'task-1',
      title: 'Preparar presentación',
      description: 'Crear las diapositivas del proyecto',
      completed: true,
    );

    expect(task.id, 'task-1');
    expect(task.title, 'Preparar presentación');
    expect(task.description, 'Crear las diapositivas del proyecto');
    expect(task.completed, isTrue);
  });
}
