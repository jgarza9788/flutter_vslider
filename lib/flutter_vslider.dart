import 'package:flutter/material.dart';

class VSlider extends StatelessWidget {
  VSlider({
    this.color,
    this.fillColor,
    this.fillShadowRadius,
    this.fillShadowColor,
    this.elevation,
    this.radius,
    this.value,
    this.icon,
    @required this.onSlide,
    this.onStart,
    this.onEnd,
  });

  final Color color;
  final Color fillColor;
  final Color fillShadowColor;
  final double fillShadowRadius;
  final double value;
  final double elevation;
  final double radius;
  final Widget icon;
  final Function onSlide;
  final Function onStart;
  final Function onEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
//      onVerticalDragUpdate: (v){
////        print(v);
//        print(v.delta.dy/300.0);
////        this.value = v.localPosition.dy/300.0;
//      },
      onVerticalDragUpdate: onSlide,
      onVerticalDragStart: onStart ,
      onVerticalDragEnd: onEnd ,

      child: AnimatedContainer(
        duration: Duration(milliseconds: 750),
        curve: Curves.easeInOut,
        child: Material(

          clipBehavior: Clip.hardEdge,
          elevation: elevation==null? 1.0:elevation,
          borderRadius: BorderRadius.circular(radius==null?25.0:radius),

          child: Container(
            height: 300.0,
            width: 100.0,
            child: Stack(
              overflow: Overflow.clip,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  color: color,
                ),

                Container(
//                color: fillColor,
                  height: this.value * 300.0,
                  decoration: BoxDecoration(
                    color: fillColor,
                    boxShadow: [
                      new BoxShadow(
                        color: fillShadowColor==null?Colors.black:fillShadowColor,
                        offset: Offset(0.0, 0.0),
                        blurRadius: fillShadowRadius==null?0.0:fillShadowRadius,
                      )
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: icon==null?Container():icon,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
