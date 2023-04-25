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
          'Please enter a title.',
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
                backgroundColor: const Color(0xFFFF4500),
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
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _selectedColor = Colors.black;
  TextEditingController _taskTitle = TextEditingController();
  TextEditingController _taskSelectedPriority = TextEditingController();
  TextEditingController _taskTime = TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskTitle = TextEditingController(
      text: widget.task == null ? null : widget.task!.title!,
    );
    _taskSelectedPriority = TextEditingController(
      text: widget.task == null ? null : widget.task!.selectedPriority!,
    );
    _taskTime = TextEditingController(
      text: widget.task == null ? null : widget.task!.time!.toString(),
    );
  }

  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Reminder:',
        body: 'You just set a new to do',
      ),
    );
  }

  String selectedPriority = 'Low priority';
  final _priorities = [
    'Low priority',
    'Medium Priority',
    'High priority',
  ];

  final _priorityColors = {
    'Low priority': Colors.blue,
    'Medium Priority': Colors.orange,
    'High priority': Colors.red,
  };

  @override
  void dispose() {
    _taskTitle?.dispose();
    _taskSelectedPriority?.dispose();
    _taskTime?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFFFF4500)),
        title: Container(
          margin: const EdgeInsets.only(top: 2, left: 10),
          child: Text(
            widget.task == null ? "Back" : "Back",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Varela Round',
              color: Color(0xFFFF4500),
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
                fillColor: Color.fromRGBO(0, 191, 255, 0.1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Write the name",
                hintStyle: const TextStyle(
                  fontFamily: 'Vareta Round',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedPriority,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    iconSize: 20,
                    elevation: 0,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPriority = newValue!;
                        _taskSelectedPriority!.text = selectedPriority;
                      });
                    },
                    items: _priorities
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Label',
                      prefixIcon: Icon(
                        Icons.label,
                        color: _priorityColors[selectedPriority],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                      );
                      if (time != null) {
                        setState(() {
                          _taskTime!.text = _timeOfDay.format(context);
                          _timeOfDay = time;
                          _selectedColor = Colors.black;
                        });
                      }
                    },
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Time',
                        prefixIcon: Icon(
                          Icons.schedule,
                          color: Color(0xFFFF4500),
                        ),
                      ),
                      controller: TextEditingController(
                        text: _timeOfDay.format(context),
                      ),
                      enabled: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _selectedColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RawMaterialButton(
                    onPressed: () async {
                      if (_taskTitle!.text.isEmpty) {
                        _showTitleRequiredDialog(context);
                      } else {
                        var newTask = Task(
                          title: _taskTitle!.text,
                          done: false,
                          selectedPriority: selectedPriority,
                          time: DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            _timeOfDay.hour,
                            _timeOfDay.minute,
                          ),
                        );
                        triggerNotification();

                        Box<Task> taskBox = Hive.box<Task>("tasks");
                        if (widget.task != null) {
                          widget.task!.title = newTask.title;
                          widget.task!.selectedPriority =
                              newTask.selectedPriority;
                          widget.task!.time = newTask.time;
                          widget.task!.save();

                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          await taskBox.add(newTask);
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        }
                      }
                    },
                    fillColor: const Color(0xFFFF4500),
                    child: Text(
                      widget.task == null ? "Add New" : "Add New",
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
