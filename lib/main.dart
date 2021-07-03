import 'dart:async';

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

  void _onColorChange(Color color) {
    setState(() => _color = color);
    _showSnackBar();
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text('Color changed!'),
      duration: new Duration(milliseconds: 250),
    ));
  }

  Future _changeColorModal() async {
    double _rValue = _color.red.toDouble();
    double _gValue = _color.green.toDouble();
    double _bValue = _color.blue.toDouble();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, innerSetState) {
            return SimpleDialog(
              title: new Text(
                'Set the color values',
                textAlign: TextAlign.center,
              ),
              children: [
                new Column(
                  children: [
                    new Container(
                      child: new Slider(
                          value: _rValue,
                          min: 0,
                          max: 255,
                          divisions: 255,
                          onChanged: (double value) {
                            innerSetState(() => _rValue = value);
                            setState(() => _color = ColorGenerator.generateColor(red: _rValue.toInt(), green: _gValue.toInt(), blue: _bValue.toInt()));
                          },
                          activeColor: Colors.red,
                          label: _rValue.round().toString()),
                      width: 200,
                    ),
                    new Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                    new Container(
                      child: new Slider(
                          value: _gValue,
                          min: 0,
                          max: 255,
                          divisions: 255,
                          onChanged: (double value) {
                            innerSetState(() => _gValue = value);
                            setState(() => _color = ColorGenerator.generateColor(red: _rValue.toInt(), green: _gValue.toInt(), blue: _bValue.toInt()));
                          },
                          activeColor: Colors.green,
                          label: _gValue.round().toString()),
                      width: 200,
                    ),
                    new Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                    new Container(
                      child: new Slider(
                          value: _bValue,
                          min: 0,
                          max: 255,
                          divisions: 255,
                          onChanged: (double value) {
                            innerSetState(() => _bValue = value);
                            setState(() => _color = ColorGenerator.generateColor(red: _rValue.toInt(), green: _gValue.toInt(), blue: _bValue.toInt()));
                          },
                          activeColor: Colors.blue,
                          label: _bValue.round().toString()),
                      width: 200,
                    ),
                    new Padding(
                      padding: EdgeInsets.all(10),
                      child: new ElevatedButton(
                        onPressed: () {
                          _onColorChange(ColorGenerator.generateColor(
                              red: _rValue.toInt(),
                              green: _gValue.toInt(),
                              blue: _bValue.toInt()));
                          Navigator.pop(context);
                        },
                        child: new Text('Save'),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Scaffold(
        key: _scaffoldState,
        appBar: new AppBar(
          title: new Text('Flutter application'),
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
      onLongPress: _changeColorModal,
    );
  }
}
