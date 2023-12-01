import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_diaries/db/db_helper.dart';
import 'package:flutter_diaries/screens/adddiaries.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchDiaries();
  }

  Future<void> _fetchDiaries() async {
    List<Map<String, dynamic>> diaries =
        await _databaseHelper.getAllDiariesRaw();
    setState(() {
      this.diaries = diaries;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          diaries.isEmpty
              ? const Center(
                  child: Text(
                    'No data available.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : CarouselSlider(
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
                  items: diaries.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            // Your onTap logic here
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
              activeDotColor: const Color.fromARGB(255, 240, 243, 255),
            ),
          ),
          TextButton(
            onPressed: () async {
              await _fetchDiaries();
            },
            child: Text("Refresh Data"),
          ),
          TextButton(
            onPressed: () async {
              await _databaseHelper.deleteAllDiaries();
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
}
