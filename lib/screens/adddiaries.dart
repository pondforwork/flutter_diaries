import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_diaries/db/db_helper.dart';
import 'package:flutter_diaries/main.dart';
import 'package:image_picker/image_picker.dart';

class AddDiariesForm extends StatefulWidget {
  @override
  _AddDiariesFormState createState() => _AddDiariesFormState();
}

class _AddDiariesFormState extends State<AddDiariesForm> {
  @override
  void initState() {
    imgpath = "";
    print(imgpath);
    super.initState();
  }

  final titleFormController = TextEditingController();
  final storyFromController = TextEditingController();
  late String imgpath = "";
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  File? _pickedImage;

  Future<void> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image?.path);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
      imgpath = image.path;
    }
  }

  final snackBar = SnackBar(
    content: const Text('Please Select Image'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 340,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 130,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What is your memories?',
                    labelText: 'Title',
                  ),
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                  controller: titleFormController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'How it\'s going',
                    labelText: 'Details',
                  ),
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                  controller: storyFromController,
                ),
                if (_pickedImage != null)
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Image.file(_pickedImage!,
                        width: 270, height: 370, fit: BoxFit.cover),
                  ),
                TextButton(
                  onPressed: () {
                    _fetchDiaries();
                  },
                  child: Text("getData"),
                ),
                // TextButton(
                //   onPressed: () {
                //     _databaseHelper.insertData();
                //     setState(() {
                //       setState(() {
                //         Navigator.pop(context,
                //             true); // Close the current screen and return true
                //       });
                //     });
                //   },
                //   child: Text("Insert Data"),
                // ),
                TextButton(
                  onPressed: () {
                    if (imgpath != "") {
                      var title = titleFormController.text;
                      var story = storyFromController.text;
                      print(title);
                      print(story);
                      print(imgpath);
                      _databaseHelper.insertDataViaForm(imgpath, title, story);
                      setState(() {
                        Navigator.pop(context,
                            true); // Close the current screen and return true
                      });
                    } else {
                      imgpath = "";
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      print("Snackbar");
                    }
                    // _databaseHelper.insertData();
                  },
                  child: Text("Save"),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await pickImage();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

Future<void> _fetchDiaries() async {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> diaries = await _databaseHelper.getAllDiariesRaw();
  print(diaries);
}
