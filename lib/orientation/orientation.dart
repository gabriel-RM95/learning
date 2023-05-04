import 'package:flutter/material.dart';

class OrientationLearning extends StatefulWidget {
  const OrientationLearning({Key? key}) : super(key: key);

  @override
  OrientationLearningState createState() => OrientationLearningState();
}

class OrientationLearningState extends State<OrientationLearning> {
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orientation'),
          centerTitle: true,
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          ),
          child: orientation == Orientation.portrait
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 15,
                  itemExtent: 150,
                  itemBuilder: (context, index) => ListItem(
                    color: Colors.primaries[index % Colors.primaries.length],
                  ),
                )
              : LayoutBuilder(builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final itemHeight = width * 0.5 / 2;
                  return ClipRect(
                    child: OverflowBox(
                      maxHeight: constraints.maxHeight + itemHeight,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: itemHeight / 2, bottom: itemHeight),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 2),
                        itemCount: 16,
                        itemBuilder: (context, index) => Transform.translate(
                          offset: index.isOdd
                              ? Offset(0.0, itemHeight / 2 - 5)
                              : Offset.zero,
                          child: ListItem(
                            color: Colors
                                .primaries[index % Colors.primaries.length],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [color, color.withAlpha(50)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              'Some data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.ac_unit,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
