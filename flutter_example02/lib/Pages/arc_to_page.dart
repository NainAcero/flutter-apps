import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:meta/meta.dart' show required;

class ArcToPage extends StatefulWidget {
  @override
  _ArcToPageState createState() => _ArcToPageState();
}

class _ArcToPageState extends State<ArcToPage> with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  Animation<double>? _startAngle;
  
  @override
  void initState() {
    super.initState();
     _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _startAngle = Tween<double>(begin: 0.0, end: 360.0).animate(_controller!);
    _controller?.repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: Colors.black12,
             child: AnimatedBuilder(
              animation: _startAngle!,
              child: Container(
                color: Colors.redAccent,
                child: Image.asset(
                  'assets/usuarios.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              builder: (_, child) {
                return ClipPath(
                  clipper: MyArcToClipper(
                    startAngle: _startAngle!.value,
                    sweepAngle: 90,
                  ),
                  child: child,
                );
              }
             )
          )
        )
      )
    );
  }
}

class MyArcToClipper extends CustomClipper<Path> {

  final double? startAngle, sweepAngle;

  MyArcToClipper({@required this.startAngle, @required this.sweepAngle});

  double toRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  @override
  Path getClip(Size size) {
    final path = Path();
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final startAngle = toRadians(this.startAngle!);
    final sweepAngle = toRadians(this.sweepAngle!);

    path.arcTo(rect, startAngle, sweepAngle, true);
    path.lineTo(size.width * 0.5, size.height * 0.5);
    return path;
    }
  
    @override
    bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}