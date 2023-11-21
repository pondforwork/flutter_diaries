import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_diaries/screens/reading.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        scaffoldBackgroundColor: Colors.yellow,
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
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
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
                  return GestureDetector(
                    onTap: () {
                      print(myCurrentIndex);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FormScreen();
                      }));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item['image'] ?? '',
                          width: 300,
                          height: 400,
                          fit: BoxFit
                              .cover, // Use BoxFit.cover to maintain aspect ratio
                        ), // Use null-aware operator
                        const SizedBox(
                            height:
                                25), // Add some space between image and text
                        Text(
                          item['text'] ?? '', // Use null-aware operator
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 150,
          ),
          AnimatedSmoothIndicator(
            activeIndex: myCurrentIndex,
            count: myItems.length,
            effect: const SlideEffect(
                spacing: 7.0,
                radius: 90,
                dotWidth: 10.0,
                dotHeight: 10.0,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5,
                dotColor: Colors.grey,
                activeDotColor: const Color.fromARGB(255, 240, 243, 255)),
          )
        ],
      ),
    );
  }
}
