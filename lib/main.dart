import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_prep.dart';

void main() async {
  runApp(const MaterialApp(
    home: ViewPrep(),
  ));
}

class ViewPrep extends StatefulWidget {
  const ViewPrep({Key? key}) : super(key: key);

  @override
  ViewPrepState createState() {
    return ViewPrepState();
  }
}

class ViewPrepState extends State<ViewPrep> {
  String prepTitle = '';

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) => {
      setState(() {
        prepTitle = prefs.getString('title') ?? '';
      })
    });

    Text title = Text(
      'Homework: ' + prepTitle,
      textAlign: TextAlign.left,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
    );

    ElevatedButton newPrep = ElevatedButton(
      child: const Text('New Prep'),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPrep())
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prep Diary'),
      ),
      body: Column(
        children: [
          title,
          newPrep
        ],
      ),
    );
  }
}

class NewPrep extends StatelessWidget {
  const NewPrep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prep Diary',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('New Prep'),
        ),
        body: Column(
          children: const [
            NewPrepForm()
          ],
        ),
      ),
    );
  }
}
