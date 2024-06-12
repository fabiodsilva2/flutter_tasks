import 'package:curso_flutter/components/task.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter ', 'assets/images/Flutter.png', 3),
    Task('Andar de bike', 'assets/images/bike.jpeg', 5),
    Task('Meditar', 'assets/images/Meditar.jpeg', 4),
    Task('Ler livro', 'assets/images/ler-livro.jpg', 2),
    Task('Jogar Nintendo', 'assets/images/jogar.jpg', 1),
  ];

  void newTask(String name, String photo, int dificulty){

    taskList.add(Task(name, photo, dificulty));

  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length!=taskList.length;
  }
}
