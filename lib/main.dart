import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_prep.dart';

void main() async {
  runApp(const MaterialApp(
    home: ViewPrep(),
  ));
}

class ViewPrep extends StatelessWidget {
  const ViewPrep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Text title = const Text(
      'Homework:',
      textAlign: TextAlign.left,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
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
