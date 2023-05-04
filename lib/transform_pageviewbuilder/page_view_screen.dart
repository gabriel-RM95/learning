import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'fake_data.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  PageViewScreenState createState() => PageViewScreenState();
}

class PageViewScreenState extends State<PageViewScreen> {
  final _pageController = PageController();
  double? _currentPage = 0.0;

  void _listener() {
    setState(() {
      _currentPage = _pageController.page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform & PageViewBuilder'),
      ),
      body: Center(
        child: PageView.builder(
          controller: _pageController,
          itemCount: items.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            double value = (index - _currentPage!);
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003)
                ..rotateY(pi / 2 * value)
                ..scale(1 - (value.abs())),
              child: Opacity(
                opacity: (1.0 - value.abs()).clamp(0.0, 1.0),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            items[index].image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 0,
                        left: 0,
                        child: BlurZone(index),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BlurZone extends StatelessWidget {
  const BlurZone(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  items[index].title,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .apply(color: Colors.white),
                ),
                Text(
                  items[index].description,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
