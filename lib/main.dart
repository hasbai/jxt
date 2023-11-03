import 'package:flutter/material.dart';

import 'consts.dart';
import 'laundry/main.dart';

void init(){
  initLaundry();
}

void main() {
  init();
  runApp(MaterialApp(
    title: 'JXT Toolkits',
    scaffoldMessengerKey: snackbarKey,
    home: const MyApp(),
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
        labelLarge: TextStyle(fontSize: 16),
      ).apply(
        displayColor: Colors.teal[700],
      ),
    ),
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
          TabNavigator(Pages.laundry),
          TabNavigator(Pages.about),
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
            label: pageNames[Pages.laundry],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: pageNames[Pages.about],
          ),
        ],
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(this.page, {super.key});

  final Pages page;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKeys[page],
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          default:
            builder = (context) => pages[page]!;
            break;
        }
        return MaterialPageRoute(builder: builder);
      },
    );
  }
}
