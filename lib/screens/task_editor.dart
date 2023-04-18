import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:own_project/main.dart';
import '../models/task_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class TaskEditor extends StatefulWidget {
  TaskEditor({this.task, Key? key}) : super(key: key);

  Task? task;

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

void _showTitleRequiredDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(
          child: Text(
            'Title is required',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Varela Round',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: const Text(
          'Please enter a title for the TO DO.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Varela Round',
            fontSize: 16,
            fontWeight: FontWeight.w200,
          ),
        ),
        contentPadding: const EdgeInsets.all(5),
        actions: <Widget>[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B008B),
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Varela Round',
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

class _TaskEditorState extends State<TaskEditor> {
  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Reminder:',
        body: 'You just set a new to do',
        displayOnForeground: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    // TextEditingController _taskNote = TextEditingController(
    //     text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF8B008B)),
        title: Container(
          margin: const EdgeInsets.only(top: 2, left: 10),
          child: Text(
            widget.task == null ? "Add a TO DO" : "Update your TO DO",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Varela Round',
              color: Color(0xFF8B008B),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text(
                "Title",
                style: TextStyle(
                  fontFamily: 'Varela Round',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "TO DO Title",
                hintStyle: const TextStyle(
                  fontFamily: 'Vareta Round',
                ),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Divider(
            //   height: 30,
            //   thickness: 1.0,
            //   color: Color(0xFF8B008B),
            // ),
            // Container(
            //   margin: const EdgeInsets.only(left: 5),
            //   child: const Text(
            //     "Notes",
            //     style: TextStyle(
            //       fontFamily: 'Varela Round',
            //       fontSize: 22,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 12,
            // ),
            // TextField(
            //   keyboardType: TextInputType.multiline,
            //   minLines: 5,
            //   maxLines: 25,
            //   controller: _taskNote,
            //   decoration: InputDecoration(
            //     fillColor: Colors.grey.shade100,
            //     filled: true,
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide.none,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     hintText: "Write some Notes",
            //     hintStyle: const TextStyle(
            //       fontFamily: 'Vareta Round',
            //     ),
            //   ),
            // ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RawMaterialButton(
                    onPressed: () async {
                      if (_taskTitle.text.isEmpty) {
                        _showTitleRequiredDialog(context);
                      } else {
                        var newTask = Task(
                          title: _taskTitle.text,
                          // note: _taskNote.text,
                          creation_date: DateTime.now(),
                          done: false,
                        );
                        triggerNotification();

                        Box<Task> taskBox = Hive.box<Task>("tasks");
                        if (widget.task != null) {
                          widget.task!.title = newTask.title;
                          // widget.task!.note = newTask.note;
                          widget.task!.save();

                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          await taskBox.add(newTask);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        }
                      }
                    },
                    fillColor: const Color(0xFF8B008B),
                    child: Text(
                      widget.task == null ? "Add new TO DO" : "Update TO DO",
                      style: const TextStyle(
                        fontFamily: 'Varela Round',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
