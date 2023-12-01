import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_diaries/db/db_helper.dart';
import 'package:image_picker/image_picker.dart';

class AddDiariesForm extends StatefulWidget {
  
  @override
  _AddDiariesFormState createState() => _AddDiariesFormState();
}

class _AddDiariesFormState extends State<AddDiariesForm> {
      DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  File? _pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

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
                ),
                if (_pickedImage != null)
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Image.file(
                      _pickedImage!,
                      width: 270,
                      height: 370,
                      fit: BoxFit.cover
                    ),
                  ),
                  TextButton(onPressed: (){
                    _fetchDiaries();
                  }, child: Text("getData"),),
                   TextButton(onPressed: (){
                    _databaseHelper.insertData();
                  }, child: Text("Insert Data"),)
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
    List<Map<String, dynamic>> diaries =
        await _databaseHelper.getAllDiariesRaw();
    print(diaries);
  }