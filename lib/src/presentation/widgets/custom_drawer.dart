import 'package:complex_ui/src/presentation/screens/01-home/home.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          microseconds: 250,
        ));
  }

  void _toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();
  static const double maxSlide = 225.0;

  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  bool _canBeDragged = false;
  int position = 0;
  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragOpenFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;
    _canBeDragged = isDragOpenFromLeft || isDragOpenFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  open() => _animationController.forward();
  close() => _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    var myDrawer = Container(color: Colors.blue);
    var myChild = Home(toggleDrawer: _toggle);
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            double slide = maxSlide * _animationController.value;
            double scale = 1 - (_animationController.value * 0.3);
            return Stack(
              children: [
                myDrawer,
                Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: myChild),
              ],
            );
          }),
    );
  }
}
