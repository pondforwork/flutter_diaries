import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  final Map<String, dynamic> imageData;

  const FormScreen({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text(imageData['text']),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Card(
              child: Container(
                height: 420.0,
                width: 320,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Center(
                      child: Image.asset(
                        imageData['image'],
                        width: 300,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                      // child: Image.asset('image01.png')
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              imageData['text'],
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
            )
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
