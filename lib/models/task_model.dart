import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? note;

  @HiveField(2)
  // ignore: non_constant_identifier_names
  DateTime? creation_date;

  @HiveField(3)
  bool? done;

  // ignore: non_constant_identifier_names
  Task({required this.title, this.note, this.creation_date, this.done});
}
