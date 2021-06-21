import 'package:flutter/material.dart';
import 'package:flutter_maps/models/place.dart';

class MyCustomMarker extends CustomPainter {

  final Place place;

  MyCustomMarker(this.place);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = Colors.green;

    final height = size.height - 15;

    final RRect rrect = RRect.fromLTRBR(0,0,size.width,height,Radius.circular(35),);
    canvas.drawRRect(rrect, paint);

    final rect = Rect.fromLTWH(size.width / 2 - 2.5, height, 5, 15);
    canvas.drawRect(rect, paint);

    paint.color = Colors.white;

    canvas.drawCircle(Offset(30, height / 2),12,paint,);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: this.place.title,
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: size.width - 65);

    textPainter.paint(
      canvas,
      Offset(50, height / 2 - textPainter.height / 2),
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}