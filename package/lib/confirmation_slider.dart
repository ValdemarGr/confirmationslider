library confirmation_slider;

import 'dart:io';

import 'package:flutter/material.dart';

typedef Widget WidgetBuilder(Widget child);

class ConfirmationSlider extends StatefulWidget {
  final ValueChanged<double> valueChanged;
  final double height;
  final double horizontalMargin;
  final VoidCallback confirmation;
  final Widget slideIcon;
  final bool consumes;
  final WidgetBuilder background;
  final Duration slidebackDuration;
  final Curve slidebackCurve;

  ConfirmationSlider({
    this.height = 50.0,
    this.horizontalMargin = 50.0,
    this.valueChanged,
    this.consumes = false,
    @required
    this.confirmation,
    @required
    this.slideIcon,
    this.background,
    this.slidebackDuration = const Duration(milliseconds: 1000),
    this.slidebackCurve = Curves.easeOut
  });

  @override
  ConfirmationSliderState createState() {
    return new ConfirmationSliderState();
  }
}

class ConfirmationSliderState extends State<ConfirmationSlider> with TickerProviderStateMixin {
  ValueNotifier<double> valueListener = ValueNotifier(0.0);

  AnimationController controller;
  Animation curve;
  Animation<double> pos;

  @override
  void initState() {
    valueListener.addListener((){
      if (widget.valueChanged != null) {
        widget.valueChanged(valueListener.value);
      }
    });

    super.initState();
  }
  
  double getPush(BuildContext context) => widget.consumes ? (widget.horizontalMargin + valueListener.value * MediaQuery.of(context).size.width) : widget.horizontalMargin;
  double getMaxPush(BuildContext context) {
    return widget.consumes ? 1.0 - (widget.horizontalMargin * 2 + widget.height) / MediaQuery.of(context).size.width : 1.0;
  } 

  @override
  Widget build(BuildContext context){

    final GestureDetector sliderDetector = new GestureDetector(
      onHorizontalDragEnd: (dragEnd) {
        if (valueListener.value == getMaxPush(context)) {
          widget.confirmation();
        }
        setState(() {
          final actualVal = (valueListener.value) < 1 ? (valueListener.value) : 0.99;
          final dur = valueListener.value * 2 * widget.slidebackDuration.inMilliseconds;
          this.controller = AnimationController(duration: Duration(milliseconds: dur.toInt()), vsync: this);
          this.curve = CurvedAnimation(parent: this.controller, curve: widget.slidebackCurve);
          this.pos = Tween(begin: 0.0, end: 1.0 - actualVal).animate(this.curve)
            ..addListener(() {
            setState(() {
              valueListener.value =  1.0 - controller.value;
            });
          });
          this.controller.forward(from: 1.0 - actualVal);
        });
      },
      onHorizontalDragUpdate: (details) {
        valueListener.value = (valueListener.value +
                details.delta.dx / (context.size.width - (widget.horizontalMargin * 2 + (widget.consumes ? (0 - widget.height) : widget.height))))
            .clamp(.0, getMaxPush(context));
      },
      child: widget.slideIcon,
    );

    return new AnimatedBuilder(
      animation: valueListener,
      builder: (context, child) {
        return Container(
          height: widget.height,
          margin: EdgeInsets.only(
            left: getPush(context),
            right: widget.horizontalMargin
            ),
          child: (widget.background == null)
            ? Align(
            alignment: Alignment(
              widget.consumes ? -1.0 : valueListener.value * 2 - 1,
              0.5),
            child: child,
          )
          : widget.background(Align(
            alignment: Alignment(
              widget.consumes ? -1.0 : valueListener.value * 2 - 1,
              0.5),
            child: child,
          ))
        );
      },
      child: sliderDetector
    );
  }
}