import 'package:flutter/material.dart';

import 'about.dart';
import 'laundry/main.dart';

void main() {
  runApp(MaterialApp(
    title: 'JXT Toolkits',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      textTheme:  const TextTheme(
        bodySmall: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 16),
        bodyLarge: TextStyle(fontSize: 24),
        displaySmall: TextStyle(fontSize: 16),
        displayMedium: TextStyle(fontSize: 16),
        displayLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const DefaultTextStyle(
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  final List<String> labels = [
    'Laundry',
    'About',
  ];

  final List<Widget> pages = [
    const Laundry(),
    const About(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(labels[_index]),
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: labels[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: labels[1],
          ),
        ],
      ),
    );
  }
}