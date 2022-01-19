import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

import 'models/homework_model.dart';
import 'models/model_manager.dart';

class ViewHwkInfo extends StatelessWidget {
  final Homework hwk;
  final int idx;

  const ViewHwkInfo(this.idx, this.hwk, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hwk.subject),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
                hwk.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
                hwk.description
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Date Due: ' + hwk.formattedDate,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
                'File Location: ' + hwk.imagePath,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
            ),
          ),

          Expanded(
              child: PhotoView(
                  imageProvider: FileImage(File(hwk.imagePath), scale: 0.2)
              ),
          ),

          ElevatedButton(
            child: const Text('Delete Homework'),
            onPressed: () {
              DBManager.deleteHomework(idx);
              Navigator.pop(context);
            },
          ),
        ],
      )
    );
  }
}