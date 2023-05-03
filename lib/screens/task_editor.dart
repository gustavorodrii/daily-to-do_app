// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:own_project/main.dart';
// import '../models/task_model.dart';

// class TaskEditor extends StatefulWidget {
//   TaskEditor({this.task, Key? key}) : super(key: key);

//   Task? task;

//   @override
//   State<TaskEditor> createState() => _TaskEditorState();
// }

// class _TaskEditorState extends State<TaskEditor> {
//   TextEditingController _taskTitle = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _taskTitle = TextEditingController(
//       text: widget.task == null ? null : widget.task!.title!,
//     );
//   }

//   @override
//   void dispose() {
//     _taskTitle.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Color(0xFFFF4500)),
//         title: Container(
//           margin: const EdgeInsets.only(top: 2, left: 10),
//           child: Text(
//             widget.task == null ? "Back" : "Back",
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Varela Round',
//               color: Color(0xFFFF4500),
//             ),
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(left: 5),
//               child: const Text(
//                 "Title",
//                 style: TextStyle(
//                   fontFamily: 'Varela Round',
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             TextField(
//               controller: _taskTitle,
//               decoration: InputDecoration(
//                 fillColor: const Color.fromRGBO(0, 191, 255, 0.1),
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 hintText: "Write the name",
//                 hintStyle: const TextStyle(
//                   fontFamily: 'Vareta Round',
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Align(
//                 alignment: FractionalOffset.bottomCenter,
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 60,
//                   child: RawMaterialButton(
//                     onPressed: () async {
//                       if (_taskTitle.text.isEmpty) {
//                       } else {
//                         var newTask = Task(
//                           title: _taskTitle.text,
//                           done: false,
//                         );

//                         Box<Task> taskBox = Hive.box<Task>("tasks");
//                         if (widget.task != null) {
//                           widget.task!.title = newTask.title;

//                           widget.task!.save();

//                           Navigator.pop(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const HomePage()));
//                         } else {
//                           await taskBox.add(newTask);
//                           // ignore: use_build_context_synchronously
//                           Navigator.pop(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const HomePage()));
//                         }
//                       }
//                     },
//                     fillColor: const Color(0xFFFF4500),
//                     child: Text(
//                       widget.task == null ? "Add New" : "Add New",
//                       style: const TextStyle(
//                         fontFamily: 'Varela Round',
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
