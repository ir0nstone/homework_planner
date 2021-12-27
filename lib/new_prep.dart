import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPrepForm extends StatefulWidget {
  const NewPrepForm({Key? key}) : super(key: key);

  @override
  NewPrepFormState createState() {
    return NewPrepFormState();
  }
}

class NewPrepFormState extends State<NewPrepForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final subjectController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
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

          // Submit Button
          ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saving Homework...')),
              );

              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('title', titleController.text);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}