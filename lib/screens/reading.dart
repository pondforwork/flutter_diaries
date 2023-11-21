import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [Text("Test"),Text("2")],
        )),
      ),
    );
  }
}
