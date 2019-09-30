import 'package:flutter/material.dart';
import 'package:flutter_vslider/flutter_vslider.dart';

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





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('vSlider'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: VSlider(
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
              setState(() {
                elevation = 24.0;
              });
            },
            onEnd: (details){
              print('onEnd $details');
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


