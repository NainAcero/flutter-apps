import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 12 / 10,
            child: ClipPath(
              clipper: BezierClipper(),
              child: Container(
                color: Colors.blueAccent,
                child: Image.asset(
                  'assets/usuarios.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),

                CupertinoButton(
                  padding: EdgeInsets.zero,
                  pressedOpacity: 0.8,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.red,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 5,
                          offset: Offset(0, 2)
                        )
                      ]
                    )
                  ),
                  onPressed: () {},
                ),

                CupertinoButton(
                  child: Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                  padding: EdgeInsets.all(10),
                ),
              ]
            )
          )
        ],
      ),
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Offset p0 = Offset(0, size.height * 0.9);
    final Offset p1 = Offset(size.width * 0.5, size.height * 1.09);
    final Offset p2 = Offset(size.width, size.height * 0.9);

    final path = Path();
    path.lineTo(p0.dx, p0.dy);
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    path.lineTo(size.width, 0);

    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

}