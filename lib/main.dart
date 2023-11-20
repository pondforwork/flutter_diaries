import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        scaffoldBackgroundColor: Colors.green,
      ),
      // theme: new ThemeData(scaffoldBackgroundColor: const Color(#FFEFEF)),

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
  final myItems = [
    {'image': 'assets/images/image01.png', 'text': 'Text 1'},
    {'image': 'assets/images/image02.png', 'text': 'Text 2'},
    {'image': 'assets/images/image03.png', 'text': 'Text 3'},
    {'image': 'assets/images/image04.png', 'text': 'Text 4'},
    {'image': 'assets/images/image05.png', 'text': 'Text 5'},
    {'image': 'assets/images/image06.png', 'text': 'Text 6'},
  ];

  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              height: 500,
              enlargeCenterPage: true,
              aspectRatio: 3 / 4,
              onPageChanged: (index, reason) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
            ),
            items: myItems.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item['image'] ?? '',
                        width: 300,
                        height: 400,
                        fit: BoxFit
                            .cover, // Use BoxFit.cover to maintain aspect ratio
                      ), // Use null-aware operator

                      SizedBox(
                          height: 25), // Add some space between image and text
                      Text(
                        item['text'] ?? '', // Use null-aware operator
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
