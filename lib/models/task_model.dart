// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? note;

  @HiveField(2)
  DateTime? creation_date;

  @HiveField(3)
  bool? done;

  @HiveField(4)
  String? selectedPriority;

  @HiveField(5)
  DateTime? time;

  Task(
      {this.title,
      this.time,
      this.creation_date,
      this.done,
      this.selectedPriority});
}
