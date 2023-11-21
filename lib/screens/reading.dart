import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  final Map<String, dynamic> imageData;

  const FormScreen({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Card(
              child: Container(
                height: 300.0,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        imageData['image'],
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      // child: Image.asset('image01.png')
                    ),
                  ],
                ),
              ),
            ),
            Text("Test")
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add any functionality you want when the FAB is pressed
        },
        child: Icon(Icons.add), // You can change the icon as needed
        backgroundColor:
            Colors.deepPurple, // You can change the background color as needed
      ),
    );
  }
}
