library slider_icons;

import 'package:flutter/material.dart';

class SliderIcon{
  static Widget roundSliderColor(double borderSize, double sliderHeight, Color color){
    return new Container(
      margin: EdgeInsets.all(borderSize / 2),
      width: sliderHeight - borderSize,
      height: sliderHeight - borderSize,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
    );
  }

  static Widget roundSliderImage(double borderSize, double sliderHeight, ImageProvider image){
    return new Container(
      margin: EdgeInsets.all(borderSize / 2),
      width: sliderHeight - borderSize,
      height: sliderHeight - borderSize,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: image
        ),
        shape: BoxShape.circle
      ),
    );
  }
}