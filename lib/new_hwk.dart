import 'package:flutter/material.dart';

import 'models/homework_model.dart';
import 'models/model_manager.dart';
import 'notification_service.dart';
import 'take_photo.dart';

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
        )
    );
  }
}

class NewHwkForm extends StatefulWidget {
  const NewHwkForm({Key? key}) : super(key: key);

  @override
  NewHwkFormState createState() => NewHwkFormState();
}

class NewHwkFormState extends State<NewHwkForm> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final subjectController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String imagePath = "";

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100)
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Title
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Homework Title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: titleController,
          ),

          // Description
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Homework Description',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: descController,
          ),

          // Subject
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Subject',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: subjectController,
          ),

          // Input Date Button
          ElevatedButton(
            child: const Text('Set Due Date'),
            onPressed: () => _selectDate(context),
          ),

          // Add Image Button
          ElevatedButton(
            onPressed: () async {
              imagePath = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TakePictureScreen()),
              );
            },
            child: const Text('Add Image'),
          ),

          // Submit Button
          ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) return;

              Homework hwk = Homework(
                title: titleController.text,
                description: descController.text,
                subject: subjectController.text,
                dueDate: selectedDate,
                imagePath: imagePath
              );

              DBManager.addHomework(hwk);

              // schedule notification
              String title = hwk.title + ' Homework Due!';
              String description = 'You have homework due tomorrow!';

              // default datetime is midnight, which is great
              // want it at 8am the day before
              DateTime notifTime = hwk.dueDate.add(const Duration(days: -1, hours: 8));
              Duration duration = notifTime.difference(DateTime.now());

              NotificationService().scheduleNotification(title, description, duration);

              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}