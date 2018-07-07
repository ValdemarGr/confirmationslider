import 'package:flutter/material.dart';

class ConfirmationSlider extends StatefulWidget {
  final ValueChanged<double> valueChanged;
  final double height;
  final double horizontalMargin;
  final Decoration decoration;
  final VoidCallback confirmation;
  final Widget slideIcon;
  final bool consumes;

  ConfirmationSlider({
    this.height = 50.0,
    this.horizontalMargin = 50.0,
    this.valueChanged,
    this.decoration,
    this.confirmation,
    this.slideIcon,
    this.consumes = false
  });

  @override
  ConfirmationSliderState createState() {
    return new ConfirmationSliderState();
  }
}

class ConfirmationSliderState extends State<ConfirmationSlider> {
  ValueNotifier<double> valueListener = ValueNotifier(0.0);

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
      },
      onHorizontalDragUpdate: (details) {
        valueListener.value = (valueListener.value +
                details.delta.dx / (context.size.width - (widget.horizontalMargin * 2 + (widget.consumes ? 0 : widget.height))))
            .clamp(.0, getMaxPush(context));
      },
      child: widget.slideIcon,
    );

    return new AnimatedBuilder(
      animation: valueListener,
      builder: (context, child) {
        print(valueListener.value);

        return new Container(
          height: widget.height,
          margin: EdgeInsets.only(
            left: getPush(context),
            right: widget.horizontalMargin
            ),
          decoration: widget.decoration,
          child: new Align(
            alignment: Alignment(
              widget.consumes ? -1.0 : valueListener.value * 2 - 1,
              0.5),
            child: child,
          ),
        );
      },
      child: sliderDetector
    );
  }
}