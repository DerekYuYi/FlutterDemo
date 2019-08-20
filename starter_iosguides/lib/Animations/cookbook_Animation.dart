import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicsCardDragDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DraggableCard(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

/// A draggable card that moves back to [Alignment.center] when it's
/// released.
class DraggableCard extends StatefulWidget {
  final Widget child;
  DraggableCard({this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;

  Animation<Alignment> _animation;

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    /// Calculate the velocity relative to the uint interval, [0, 1],
    /// used by the animation controller.
    final unitPerSecondX = pixelPerSecond.dx / size.width;
    final unitPerSecondY = pixelPerSecond.dy / size.height;
    final unitPerSecond = Offset(unitPerSecondX, unitPerSecondY);
    final unitVelocity = unitPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    // Calls the listener every time the value of the animation changes.
    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
    super.initState();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );

  }
}