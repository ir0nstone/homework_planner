import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'homework_model.g.dart';

@HiveType(typeId: 0)
class Homework {
  @HiveField(0) final String title;
  @HiveField(1) final String description;
  @HiveField(2) final String subject;
  @HiveField(3) final DateTime dueDate;
  @HiveField(4) final String imagePath;

  Homework({
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate,
    required this.imagePath
  });

  String get formattedDate {
    return DateFormat('dd/MM/yyyy').format(dueDate);
  }
}