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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title!,
                  style: const TextStyle(
                    fontFamily: 'Varela Round',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskEditor(
                                task: widget.task,
                              )));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.task.delete();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xFF8B008B),
            height: 20,
            thickness: 1,
          ),
          Text(
            widget.task.note!,
            style: const TextStyle(
              fontFamily: 'Varela Round',
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
