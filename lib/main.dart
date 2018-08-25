
import 'package:flutter/material.dart';

import 'confirmation_slider.dart';
import 'slider_decorations.dart';
import 'slider_icon.dart';

void main() => runApp(
    new MaterialApp(
      home: new MyApp()
    )
  );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new ListView(
          children: <Widget>[
            new Container(height: 200.0,),

            new ConfirmationSlider(
              height: 100.0,
              //slideIcon: SliderIcon.roundSliderColor(10.0, 50.0, Colors.red),
              slideIcon: SliderIcon.roundSliderImage(20.0, 100.0, NetworkImage("https://i.imgur.com/oK7nESn.png")),
              confirmation: () {
                print('hello!');
              },
              consumes: true,
              background: (child) => Container(child: child, color: Colors.black,), // (child) => Widget(child: child)
              slidebackDuration: Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
    );
  }
}
