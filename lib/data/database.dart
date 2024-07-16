import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List todoList = [];
  final _mybox = Hive.box('mybox');

  void createInitialData() {
    todoList = [
      ['make tutorial', false],
      ['Do Excersise', false],
    ];
  }

  void loadDataBase() {
    todoList = _mybox.get('TODOLIST');
  }

  void updateDatabase() {
    _mybox.put('TODOLIST', todoList);
  }
}
