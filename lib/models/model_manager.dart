import 'package:hive/hive.dart';

import 'homework_model.dart';

class DBManager {
  static const String hwkBoxName = 'homework';

  static addHomework(Homework hwk) {
    var box = Hive.box(hwkBoxName);
    box.add(hwk);
  }

  static deleteHomework(Homework hwk) {
    var box = Hive.box(hwkBoxName);
    box.delete(hwk);
  }

  static List<dynamic> getHomeworks() {
    final box = Hive.box(hwkBoxName);
    return box.values.toList();
  }
}
