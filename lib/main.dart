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
  Color _color = Colors.white;

  void _changeColor(Color color) => setState(() => _color = color);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Scaffold(
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
      onTap: () => _changeColor(ColorGenerator.generateColor()),
    );
  }
}
