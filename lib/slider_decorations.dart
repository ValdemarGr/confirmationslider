library slider_decorations;

import 'package:flutter/material.dart';

class SliderDecorations {

  static Decoration roundedRectangleColor(Color color, double height) {
    return new ShapeDecoration(
      color: color,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.all(new Radius.circular(height / 2))
      )
    );
  }

  static Decoration roundedRectangleImage(double height, ImageProvider image) {
    return new ShapeDecoration(
      image: new DecorationImage(
        image: image
      ),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.all(new Radius.circular(height / 2))
      )
    );
  }
}