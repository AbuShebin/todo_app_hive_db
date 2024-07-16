import 'package:flutter/material.dart';
import 'package:todo_app_hive_db/util/myButton.dart';

class Dialoguebox extends StatefulWidget {
  final controller;
  VoidCallback onCancel;
  VoidCallback onSave;

  Dialoguebox({super.key, required this.controller, required this.onCancel,required this.onSave});

  @override
  State<Dialoguebox> createState() => _DialogueboxState();
}

class _DialogueboxState extends State<Dialoguebox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Row(
              children: [
                Mybutton(onPressed: widget.onSave, text: 'Add a new tak'),
                SizedBox(
                  width: 8,
                ),
                Mybutton(onPressed: widget.onCancel, text: 'cancel'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
