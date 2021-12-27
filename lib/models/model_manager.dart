import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'homework_model.dart';

class DBManager with ChangeNotifier {
  String boxName = 'homework';
  List _hwkList = <Homework>[];
  List get hwkList => _hwkList;

  addHomework(Homework hwk) async {
    var box = await Hive.openBox<Homework>(boxName);
    box.add(hwk);
  }

  listHomeworks() async {
    final box = await Hive.openBox<Homework>(boxName);
    _hwkList = box.values.toList();
  }
}