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
  State createState() => new _State();
}

class ColorSlider {
  double colorValue;
  Color activeColour;

  void onChange(double value, void Function(void Function()) innerSetState) {
    innerSetState(() => colorValue = value);
  }

  String get label => colorValue.toString();

  int get intColorValue => colorValue.toInt();

  ColorSlider(this.colorValue, this.activeColour);
}

class _State extends State<MyApp> {
  final GlobalKey _scaffoldState = new GlobalKey<ScaffoldState>();

  var _color = Colors.white;

  void _onColorChange(Color color) {
    setState(() => _color = color);
    _showSnackBar();
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Color changed!'),
      duration: Duration(milliseconds: 250),
    ));
  }

  Future _changeColorModal() async {
    double _rValue = _color.red.toDouble();
    double _gValue = _color.green.toDouble();
    double _bValue = _color.blue.toDouble();

    final _colorSliders = [
      ColorSlider(_rValue, Colors.red),
      ColorSlider(_gValue, Colors.green),
      ColorSlider(_bValue, Colors.blue),
    ];

    List<Widget> _createWidgetsForModal(
        void Function(void Function()) innerSetState) {
      final _slidersWithButton = List<Widget>.generate(
        3,
        (index) {
          return Slider(
            value: _colorSliders[index].colorValue,
            min: 0,
            max: 255,
            label: _colorSliders[index].label,
            onChanged: (value)
                {
                  _colorSliders[index].onChange(value, innerSetState);
                  setState(() => _color = Color.fromRGBO(_colorSliders[0].intColorValue, _colorSliders[1].intColorValue, _colorSliders[2].intColorValue, 1));
                },
            activeColor: _colorSliders[index].activeColour,
          );
        },
      );
      _slidersWithButton.add(
        ElevatedButton(
          onPressed: () {
            _onColorChange(
              Color.fromRGBO(
                  _colorSliders[0].intColorValue,
                  _colorSliders[1].intColorValue,
                  _colorSliders[2].intColorValue,
                  1),
            );
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      );
      return _slidersWithButton;
    }

    List<Widget> _sliders;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, innerSetState) {
            return WillPopScope(
                child: SimpleDialog(
                  title: Text(
                    'Set the color values',
                    textAlign: TextAlign.center,
                  ),
                  children: [
                    Column(children: _createWidgetsForModal(innerSetState)),
                  ],
                ),
                onWillPop: () async => false);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text('Flutter application'),
        ),
        body: Container(
          child: Center(
            child: Text(
              'Hey there',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        backgroundColor: _color,
      ),
      onTap: () => _onColorChange(Color.fromRGBO(
        ColorGenerator.random.nextInt(255),
        ColorGenerator.random.nextInt(255),
        ColorGenerator.random.nextInt(255),
        1,
      )),
      onLongPress: _changeColorModal,
    );
  }
}
