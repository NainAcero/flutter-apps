import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart' show required;
import 'dart:math' as math;

class Responsive {
  final double width, height, inch;

  Responsive({
    @required this.width,
    @required this.height,
    @required this.inch
  });
  
  factory Responsive.fromSize(Size size) {
    // c2 = a2+b2 => c = sqrt(a2+b2)
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }

  factory Responsive.of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;

    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }

  double wp(double porcent) {
    return this.width * porcent / 100;
  }

  double hp(double porcent) {
    return this.height * porcent / 100;
  }
 
  double ip(double porcent) {
    return this.inch * porcent / 100;
  }

}