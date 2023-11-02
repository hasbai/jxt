import 'package:flutter/material.dart';

import 'about.dart';
import 'consts.dart';
import 'laundry/main.dart';

void main() {
  runApp(MaterialApp(
    title: 'JXT Toolkits',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 14),
        bodyMedium: TextStyle(fontSize: 16),
        bodyLarge: TextStyle(fontSize: 20),
        titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ).apply(
        displayColor: Colors.teal[700],
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
    return const MyHomePage();
  }
}

const List<Widget> pages = [
  Laundry(),
  About(),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          TabNavigator(0),
          TabNavigator(1),
        ],
      ),
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
            label: tabNames[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: tabNames[1],
          ),
        ],
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          default:
            builder = (context) => pages[index];
            break;
        }
        return MaterialPageRoute(builder: builder);
      },
    );
  }
}
