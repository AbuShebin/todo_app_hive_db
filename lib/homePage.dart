import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_hive_db/data/database.dart';
import 'package:todo_app_hive_db/util/dialoguebox.dart';
import 'package:todo_app_hive_db/util/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  void checkboxChanged(bool value, int intx) {
    setState(() {
      db.todoList[intx][1] = !db.todoList[intx][1];
      print('pressed');
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    print('taask save button');
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialoguebox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: Navigator.of(context).pop,
        );
      },
    );
  }

  void deleteTask(int index) {
    print('pressed');
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadDataBase();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onchanged: (value) => checkboxChanged(value!, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
        itemCount: db.todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(),
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
    );
  }
}
