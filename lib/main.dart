import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'new_hwk.dart';
import 'models/homework_model.dart';
import 'models/model_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(HomeworkAdapter());

  Hive.openBox('homework');

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
  Container packHomework(Homework hwk) {
    return Container(
      padding: EdgeInsets.all(20),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                hwk.subject,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                hwk.title,
                style: const TextStyle(fontSize: 18)
              ),
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(hwk.dueDate),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final hwks = DBManager.getHomeworks();
    List<Container> hwkEntries = <Container>[];

    for (Homework hwk in hwks) {
      hwkEntries.add(packHomework(hwk));
    }

    Container title = Container(
      padding: const EdgeInsets.all(20),
      child: const Text(
        'Homework:',
        textAlign: TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      )
    );

    Column homeworks = Column(
      children: hwkEntries,
    );

    ElevatedButton newHwkButton = ElevatedButton(
      child: const Text('New Homework'),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewHwk())
        ).then((_) => setState(() {}));
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework Planner'),
      ),
      body: Column(
        children: [
          title,
          homeworks,
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Homework'),
        ),
        body: Column(
          children: const [
            NewHwkForm()
          ],
        ),
    );
  }
}
