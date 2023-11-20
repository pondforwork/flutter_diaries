import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Diaries'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          child: Container(
            height: 350.0,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.network(
                    'https://img.freepik.com/free-photo/side-view-smiley-woman-holding-hen_23-2149456919.jpg?w=2000&t=st=1700474527~exp=1700475127~hmac=f8e772c940c9fdc0f4fb4154c068702b8a1f4f7212f99528feb1014fe5f92f64', // Replace with your image URL
                    height: 300.0, // Set the desired height for the image
                    width: 400.0, // Set the desired width for the image
                  ),
                ),
                Center(
                  child: Text("Title"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
