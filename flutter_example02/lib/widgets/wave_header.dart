import 'package:flutter/material.dart';

class WaveHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 14 / 10,
      child: ClipPath(
        clipper: WaveClipper(),
        child: Image.asset(
          'assets/usuarios.jpg',
          fit: BoxFit.cover,
        ),
      )
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Offset p0 = Offset(0, size.height * 0.95);
    final Offset p1 = Offset(size.width * 0.25, size.height * 1.05);
    final Offset p2 = Offset(size.width * 0.5, size.height * 0.92);

    final path = Path();
    path.lineTo(p0.dx, p0.dy);
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    final Offset n1 = Offset(size.width * 0.75, size.height * 0.8);
    final Offset n2 = Offset(size.width, size.height * 0.95);

    path.quadraticBezierTo(n1.dx, n1.dy, n2.dx, n2.dy);
    path.lineTo(size.width, 0);

    return path;

  }
  
    @override
    bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

}