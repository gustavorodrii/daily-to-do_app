import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:date_format/date_format.dart';
import 'package:own_project/screens/task_editor.dart';
import 'package:own_project/widgets/my_list_tile.dart';
import 'models/task_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

late Box box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
      ),
    ],
    debug: true,
  );
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
                    "Date",
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
                                'slide to delete',
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TaskEditor()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
