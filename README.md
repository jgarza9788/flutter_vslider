# flutter_vslider

[![Open Source Love](https://badges.frapsoft.com/os/v3/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)

[![forthebadge](https://forthebadge.com/images/badges/built-for-android.svg)](https://forthebadge.com)


## Usage
to change a value


![gif](misc/Demo_20190927163224.gif)


## Example

```dart
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

//animation stuff
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
  //end animation stuff


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

```