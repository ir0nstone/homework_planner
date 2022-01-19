import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  ImagePicker picker = ImagePicker();
  late XFile pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Image")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Open Camera"),
            onTap: () {
              openPicker(ImageSource.camera);
            },
          ),
          ListTile(
              title: const Text("Take From Gallery"),
              onTap: () {
                openPicker(ImageSource.gallery);
              }
          ),
        ],
      ),
    );
  }

  //open picker after selecting option
  openPicker(ImageSource source) async {
    pickedImage = (await picker.pickImage(source: source)) as XFile;
    Navigator.pop(context, pickedImage.path);
  }
}