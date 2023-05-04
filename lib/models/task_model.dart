// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(2)
  bool? isChecked;

  Task({
    this.title,
    this.isChecked,
  });
}
