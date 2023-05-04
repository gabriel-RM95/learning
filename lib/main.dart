import 'package:flutter/material.dart';
import 'bounce_nav_bar/bounce_nav_bar.dart';
import 'orientation/orientation.dart';
import 'snake_button/snake_button.dart';
import 'transform_pageviewbuilder/page_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrientationLearning(),
                    ),
                  );
                },
                child: const Text('Orientation'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageViewScreen(),
                    ),
                  );
                },
                child: const Text('Transform & PageViewBuilder'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BounceNavBar(),
                    ),
                  );
                },
                child: const Text('Bounce Nav Bar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SnakeButton(),
                    ),
                  );
                },
                child: const Text('Snake Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
