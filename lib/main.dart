import 'package:flutter/material.dart';
import 'package:test_flutter_project/generators/color_generator.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  final GlobalKey _scaffoldState = new GlobalKey<ScaffoldState>();

  var _color = Colors.white;

  void _changeColor(Color color) {
    setState(() => _color = color);
  }

  void _onColorChange(Color color) {
    _changeColor(color);
    _showSnackBar();
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text('Color changed!'),
      duration: new Duration(milliseconds: 250),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Scaffold(
        key: _scaffoldState,
        appBar: new AppBar(
          title: new Text('Name here'),
        ),
        body: new Container(
          child: new Center(
            child: new Text(
              'Hey there',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        backgroundColor: _color,
      ),
      onTap: () => _onColorChange(ColorGenerator.generateColor(
          red: ColorGenerator.random.nextInt(255),
          green: ColorGenerator.random.nextInt(255),
          blue: ColorGenerator.random.nextInt(255))),
    );
  }
}
