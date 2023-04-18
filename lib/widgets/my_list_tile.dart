import 'package:flutter/material.dart';
import 'package:own_project/screens/task_editor.dart';
import '../models/task_model.dart';

class MyListTile extends StatefulWidget {
  MyListTile(this.task, this.index, {Key? key}) : super(key: key);

  Task task;
  int index;

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          widget.task.delete();
        });
      },
      background: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.task.title!,
                    style: TextStyle(
                      fontFamily: 'Varela Round',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration:
                          _isChecked ? TextDecoration.lineThrough : null,
                      decorationColor: _isChecked ? Color(0xFF8B008B) : null,
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.0,
                  child: Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                    activeColor: const Color(0xFF8B008B),
                    checkColor: Colors.white,
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.task.delete();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xFF8B008B),
                    size: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
