import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_diaries/db/db_helper.dart';
import 'package:flutter_diaries/models/diaries.dart';
import 'package:flutter_diaries/screens/adddiaries.dart';
import 'package:flutter_diaries/screens/reading.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:palette_generator/palette_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        // scaffoldBackgroundColor: Color(0xff797a65),
        scaffoldBackgroundColor: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Flutter Diaries'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> diaries = [];
  int myCurrentIndex = 0;

  String? path;

  @override
  void initState() {
    super.initState();
    // _fetchDiaries();
    // print("Diart");
    // print(diaries);
    // _databaseHelper.deleteAllDiaries();
  }

  Future<void> _fetchDiaries() async {
  List<Map<String, dynamic>> diariesDB =
      await _databaseHelper.getAllDiariesRaw();
  this.diaries = diariesDB;

  if (diaries.isNotEmpty) {
    // Assuming diaries list has at least one entry
    Map<String, dynamic> firstDiary = diaries[0];
    String imagePath = firstDiary[NoteTable.image];

    // Use the imagePath to create a File object
    File imageFile = File(imagePath);

    // Now you can use imageFile as needed, for example, display it in an Image widget
    print("Image File Path: $imagePath");
    print("Image File Exists: ${imageFile.existsSync()}");
  }

  // print(diaries);
  // print("db");
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 170,
          ),
          diaries.isEmpty
              ? const Center(
                  child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                    ),
                    Center(
                      child: Text(
                        'No Diaries Here. Try Add One!!',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ))
              : CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    height: 500,
                    enlargeCenterPage: true,
                    aspectRatio: 3 / 4,
                    onPageChanged: (index, reason) async {
                      print("Test");
                      setState(() {
                        myCurrentIndex = index;
                        // generatePalette(path!);
                      });
                    },
                  ),
                  items: diaries.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () async {
                            // path = await _databaseHelper.selectImagePath(myCurrentIndex);
                            // generatePalette(path!);
                            // Your onTap logic here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormScreen(
                                  imageData: diaries[myCurrentIndex],
                                  iamgePath:
                                      '$path', // Replace with your actual value
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            print("Long Press");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Image.asset.toString()),
                              Image.asset(item['image']?? '',
                                width: 300,
                                height: 400,
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover to maintain aspect ratio
                              ),
                              // Your image or content widget here
                              const SizedBox(height: 25),
                              Text(
                                item['title'] ?? '',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
          const SizedBox(
            height: 150,
          ),
          if (diaries.isNotEmpty)
            AnimatedSmoothIndicator(
              activeIndex: myCurrentIndex,
              count: diaries.length,
              effect: const SlideEffect(
                spacing: 7.0,
                radius: 90,
                dotWidth: 10.0,
                dotHeight: 10.0,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5,
                dotColor: Colors.grey,
                activeDotColor: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          TextButton(
            onPressed: () async {
              // _databaseHelper.insertData();
              // await _fetchDiaries();
              // generatePalette();
            },
            child: Text("Refresh Data"),
          ),
          TextButton(
            onPressed: () async {
              await _databaseHelper.deleteAllDiaries();
              setState(() {
                _fetchDiaries();
              });
            },
            child: Text("Delete"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDiariesForm(),
            ),
          );
          if (result == true) {
            await _fetchDiaries();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<PaletteGenerator> generatePalette(String imagePath) {
    // Load image from file
    final imageProvider = AssetImage(imagePath);
    final paletteGenerator = PaletteGenerator.fromImageProvider(
      imageProvider,
      maximumColorCount: 1,
    );
    print(paletteGenerator);
    return paletteGenerator;
  }

  Color getColorFromPalette(PaletteGenerator? paletteGenerator) {
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      PaletteColor pickedColor = paletteGenerator.colors.first as PaletteColor;
      return pickedColor.color;
    } else {
      // Return a default color if no color is found
      return Colors
          .grey; // You can replace this with your desired default color
    }
  }
}
