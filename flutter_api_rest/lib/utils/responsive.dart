import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  double _width, _height, _diagonal;
  bool _isTablet;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTablet => _isTablet;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    this._width = size.width;
    this._height = size.height;

    this._diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
    this._isTablet = size.shortestSide >= 600;
  }

  double wp(double porcent) => _width * porcent / 100;
  double hp(double porcent) => _height * porcent / 100;
  double dp(double porcent) => _diagonal * porcent / 100;
}