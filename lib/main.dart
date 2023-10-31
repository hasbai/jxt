import 'package:flutter/material.dart';

import 'about.dart';
import 'laundry/main.dart';

void main() {
  runApp(MaterialApp(
    title: 'JXT Toolkits',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.teal,
      ),
      textTheme: const TextTheme(
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

const List<Widget> pages = [
  Laundry(),
  About(),
];

const List<String> labels = [
  'Laundry',
  'About',
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
      appBar: AppBar(
        title: Text(labels[_index]),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
        child: IndexedStack(
          index: _index,
          children: const [
            TabNavigator(0),
            TabNavigator(1),
          ],
        ),
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
