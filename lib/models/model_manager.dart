import 'package:hive/hive.dart';

import 'homework_model.dart';

class DBManager {
  static const String hwkBoxName = 'homework';

  static addHomework(Homework hwk) async {
    var box = Hive.box(hwkBoxName);
    await box.add(hwk);
  }

  static deleteHomework(int idx) async {
    var box = Hive.box(hwkBoxName);
    await box.deleteAt(idx);
  }

  static List<dynamic> getHomeworks() {
    final box = Hive.box(hwkBoxName);
    return box.values.toList();
  }
}
