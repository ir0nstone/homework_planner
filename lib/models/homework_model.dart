import 'package:hive/hive.dart';

part 'homework_model.g.dart';

@HiveType(typeId: 0)
class Homework {
  @HiveField(0) final String title;
  @HiveField(1) final String description;
  @HiveField(2) final String subject;
  @HiveField(3) final DateTime dueDate;

  Homework({
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate
  });

  @override
  String toString() {
    return 'Title: $title';
  }
}