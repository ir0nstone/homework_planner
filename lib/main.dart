import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'new_hwk.dart';
import 'models/homework_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(HomeworkAdapter());

  runApp(const MaterialApp(
    home: ViewHwk(),
  ));
}

class ViewHwk extends StatefulWidget {
  const ViewHwk({Key? key}) : super(key: key);

  @override
  ViewHwkState createState() {
    return ViewHwkState();
  }
}

class ViewHwkState extends State<ViewHwk> {
  List<dynamic> getHomeworks() {
    Hive.openBox('homework');
    final box = Hive.box('homework');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final hwks = getHomeworks();
    String info = '';

    for (Homework hwk in hwks) {
      info += hwk.toString();
    }

    Text title = Text(
      'Homework: ' + info,
      textAlign: TextAlign.left,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
    );

    ElevatedButton newHwkButton = ElevatedButton(
      child: const Text('New Homework'),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewHwk())
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework Planner'),
      ),
      body: Column(
        children: [
          title,
          newHwkButton
        ],
      ),
    );
  }
}

class NewHwk extends StatelessWidget {
  const NewHwk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework Planner',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('New Homework'),
        ),
        body: Column(
          children: const [
            NewHwkForm()
          ],
        ),
      ),
    );
  }
}
