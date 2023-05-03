import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:date_format/date_format.dart';
import 'package:own_project/widgets/my_list_tile.dart';
import 'models/task_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

late Box box;
Task? task;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskTitle = TextEditingController();
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFF4500),
        title: Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text(
            'Just do iti !',
            style: TextStyle(
              fontFamily: 'Varela Round',
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("tasks").listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Data",
                    style: TextStyle(
                      fontFamily: 'Varela Round',
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    formatDate(DateTime.now(), [d, ", ", MM, " ", yyyy]),
                    style: const TextStyle(
                      fontFamily: 'Varela Round',
                      color: Color(0xFFFF4500),
                      fontSize: 18,
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1.0,
                  ),
                  Visibility(
                    visible: box.values.isNotEmpty,
                    child: Container(
                      margin: const EdgeInsets.only(right: 7),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey,
                                size: 12,
                              ),
                              Text(
                                'deslize para deletar',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Task currentTask = box.getAt(index)!;
                      return MyListTile(currentTask, index);
                    },
                  )),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF4500),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Nova Tarefa',
                style: TextStyle(
                  color: Color(0xFFFF4500),
                  fontSize: 22,
                ),
              ),
              content: TextFormField(
                controller: _taskTitle,
                decoration: const InputDecoration(
                  hintText: 'Digite uma nova Tarefa',
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFFF4500),
                        ),
                        elevation: MaterialStateProperty.all<double>(2),
                      ),
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        if (_taskTitle.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                'Erro',
                                style: TextStyle(
                                  color: Color(0xFFFF4500),
                                ),
                              ),
                              content: const Text(
                                  'Digite uma tarefa antes de salvar.'),
                              actions: [
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Color(0xFFFF4500),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          final newTask = Task(title: _taskTitle.text);
                          box.add(newTask);
                          _taskTitle.clear();

                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                        elevation: MaterialStateProperty.all<double>(2),
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(
                            color: Color(0xFFFF4500),
                            width: 1,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Color(0xFFFF4500),
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
