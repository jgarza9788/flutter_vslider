import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{


  double value = 0.5;
  double elevation = 3.0;
  double iconOpacity = 0.25;
  double iconSize = 0.0;
  double shadowRadius = 100.0;



  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );

    //https://api.flutter.dev/flutter/animation/Curves-class.html
    animation = CurvedAnimation(parent: controller,curve: Curves.easeIn);


    animation.addStatusListener((status){
      print(status);
      //moves between forwards and back
      /*
      if(status == AnimationStatus.completed)
      {
        controller.reverse(from: 1);
      }
      else if(status == AnimationStatus.dismissed)
      {
        controller.forward(from: 0);
      }
      */
    });

    controller.addListener((){
      setState(() {
        iconSize = animation.value;
      });
//      print(controller.value);
      print('animation ${animation.value}');

    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('vSlider'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: vSlider(
            color: Colors.blueGrey[500],
            fillColor: Colors.lightGreenAccent,
            fillShadowColor: Colors.lightGreenAccent[700],
            fillShadowRadius: shadowRadius,
            elevation: elevation,
            radius: 25.0,
            value: value,
            onSlide: (v){
              print('onSlide ${-v.delta.dy}');
              value += -v.delta.dy/300.0;
              setState(() {
                value = value.clamp(0.0, 1.0);
              });
            },
            onStart: (details){
              print('onStart $details');
              controller.forward(from: 0);
              setState(() {
                elevation = 24.0;
              });
            },
            onEnd: (details){
              print('onEnd $details');
              controller.reverse(from: 1);
              setState(() {
                elevation = 3.0;
              });
            },
            icon: Icon(
              Icons.music_note,
              size: (iconSize * 10.0) + 50.0,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
        ),
      ),
    );
  }
}


//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('vSlider'),
//          backgroundColor: Colors.blueGrey,
//        ),
//        body: Center(
//          child: vSlider(
//            color: Colors.blueGrey,
//            fillColor: Colors.lightGreenAccent,
//            elevation: 12.0,
//            radius: 25.0,
//            value: 0.75,
//            onSlide: (v){
//              print(v);
//            },
//            icon: Icon(
//              Icons.music_note,
//              size: 50,
//              color: Colors.black.withOpacity(0.5),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}


class vSlider extends StatelessWidget {
  vSlider({
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

    );
  }
}


/*
class vSlider extends StatefulWidget {
  @override
  _vSliderState createState() => _vSliderState();
}

class _vSliderState extends State<vSlider> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(

        clipBehavior: Clip.hardEdge,
        elevation: 6.0,
        borderRadius: BorderRadius.circular(25.0),

        child: Container(
          height: 300.0,
          width: 100.0,
          child: Stack(
            overflow: Overflow.clip,
  //        alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                color: Colors.blueGrey,
                height: 300.0,
                width: 100.0,
              ),
              Container(
                color: Colors.blueGrey[100],
                height: 150.0,
                width: 100.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Icon(
                    Icons.music_note,
                    size: 50,
                    color: Colors.blueGrey[900],
                  ),
                ),
              )
            ],
          ),
        ),
      ),

//      child: Container(
//        height: 300.0,
//        width: 100.0,
////        color: Colors.lightBlueAccent,
//        decoration: BoxDecoration(
//          color: Colors.lightBlueAccent,
//          borderRadius: BorderRadius.circular(25.0),
//          boxShadow: [
//            new BoxShadow(
//                color: Color.fromARGB(128, 0, 0, 0),
//                offset: new Offset(0.0, 5.0),
//                blurRadius: 15.0
//            ),
//          ],
//        ),
//      ),

    );
  }
}
*/