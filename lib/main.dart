import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'new_hwk.dart';
import 'view_hwk.dart';
import 'notification_service.dart';
import 'models/homework_model.dart';
import 'models/model_manager.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await Hive.initFlutter();
  Hive.registerAdapter(HomeworkAdapter());

  await DBManager.openHomeworkBox();

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
  Container packHomework(int idx, Homework hwk) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ViewHwkInfo(idx, hwk))
          ).then((_) => setState(() {}));
        },
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
              hwk.formattedDate,
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

    for (int i = 0; i < hwks.length; i++) {
      hwkEntries.add(packHomework(i, hwks[i]));
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
            MaterialPageRoute(builder: (context) => NewHwk())
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
