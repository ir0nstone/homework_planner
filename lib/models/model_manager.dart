import 'package:hive/hive.dart';

import 'homework_model.dart';

class DBManager {
  static const String hwkBoxName = 'homework';

  static addHomework(Homework hwk) {
    Hive.openBox(hwkBoxName);
    var box = Hive.box(hwkBoxName);
    box.add(hwk);
  }

  static List<dynamic> getHomeworks() {
    Hive.openBox(hwkBoxName);
    final box = Hive.box(hwkBoxName);
    return box.values.toList();
  }
}
