import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/index_cubit.dart';

class BounceNavBar extends StatelessWidget {
  const BounceNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IndexCubit(),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Bounce Nav Bar'),
        ),
        body: Builder(builder: (context) {
          return IndexedStack(
            index: context.select((IndexCubit element) => element.state),
            children: [
              Container(
                color: Colors.teal,
              ),
              Container(
                color: Colors.blue.withOpacity(0.65),
              ),
              Container(
                color: Colors.blueGrey,
              ),
              Container(
                color: Colors.green.withOpacity(0.65),
              ),
            ],
          );
        }),
        bottomNavigationBar: const BounceNavBarWidget(),
      ),
    );
  }
}

class BounceNavBarWidget extends StatefulWidget {
  const BounceNavBarWidget({Key? key}) : super(key: key);

  @override
  State<BounceNavBarWidget> createState() => _BounceNavBarStateWidget();
}

class _BounceNavBarStateWidget extends State<BounceNavBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _barAnimationIn;
  late Animation _barAnimationOut;
  late Animation _iconAnimationIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _barAnimationIn =
        CurveTween(curve: const Interval(0.0, 0.5, curve: Curves.ease))
            .animate(_controller);
    _barAnimationOut =
        CurveTween(curve: const Interval(0.5, 1.0, curve: Curves.bounceOut))
            .animate(_controller);

    _iconAnimationIn =
        CurveTween(curve: const Interval(0.25, 0.5, curve: Curves.ease))
            .animate(_controller);
    _controller.forward(from: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double currentWidth = width;
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          currentWidth = width -
              (_barAnimationIn.value * 100) +
              (_barAnimationOut.value * 100);
          int index = context.select((IndexCubit element) => element.state);
          return Center(
            child: Material(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: SizedBox(
                width: currentWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: CustomPaint(
                        foregroundPainter: index == 0
                            ? CircleCustomPainter(_barAnimationIn.value)
                            : null,
                        child: Transform.translate(
                          offset: index == 0
                              ? Offset(
                                  0.0,
                                  -_iconAnimationIn.value * 70 +
                                      _barAnimationOut.value * 55)
                              : Offset.zero,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                _controller.forward(from: 0.0);
                                context.read<IndexCubit>().tabPressed(0);
                              },
                              icon: const Icon(Icons.home),
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomPaint(
                        foregroundPainter: index == 1
                            ? CircleCustomPainter(_barAnimationIn.value)
                            : null,
                        child: Transform.translate(
                          offset: index == 1
                              ? Offset(
                                  0.0,
                                  -_iconAnimationIn.value * 70 +
                                      _barAnimationOut.value * 55)
                              : Offset.zero,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                _controller.forward(from: 0.0);
                                context.read<IndexCubit>().tabPressed(1);
                              },
                              icon: const Icon(Icons.store),
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomPaint(
                        foregroundPainter: index == 2
                            ? CircleCustomPainter(_barAnimationIn.value)
                            : null,
                        child: Transform.translate(
                          offset: index == 2
                              ? Offset(
                                  0.0,
                                  -_iconAnimationIn.value * 70 +
                                      _barAnimationOut.value * 55)
                              : Offset.zero,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                _controller.forward(from: 0.0);
                                context.read<IndexCubit>().tabPressed(2);
                              },
                              icon: const Icon(Icons.favorite),
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomPaint(
                        foregroundPainter: index == 3
                            ? CircleCustomPainter(_barAnimationIn.value)
                            : null,
                        child: Transform.translate(
                          offset: index == 3
                              ? Offset(
                                  0.0,
                                  -_iconAnimationIn.value * 70 +
                                      _barAnimationOut.value * 55)
                              : Offset.zero,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                _controller.forward(from: 0.0);
                                context.read<IndexCubit>().tabPressed(3);
                              },
                              icon: const Icon(Icons.person),
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CircleCustomPainter extends CustomPainter {
  final double progress;

  CircleCustomPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final radius = 25.0 * progress;
    final strokeWidth = 10.0 * (1 - progress);
    final paint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    if (progress < 1) canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
