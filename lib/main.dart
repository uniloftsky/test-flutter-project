import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

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
  late Widget slider;

  ColorSlider(double colorValue, Color activeColor,
      void Function(double value) setState) {
    this.slider = StatefulBuilder(
      builder: (context, innerSetState) {
        return Slider(
          value: colorValue,
          activeColor: activeColor,
          min: 0,
          max: 255,
          divisions: 255,
          label: colorValue.round().toString(),
          onChanged: (value) {
            innerSetState(() => colorValue = value);
            setState(value);
          },
        );
      },
    );
  }
}

class _State extends State<MyApp> {
  final GlobalKey _scaffoldState = new GlobalKey<ScaffoldState>();
  static final random = Random();

  late Color _color;
  late double _rValue, _gValue, _bValue;

  @override
  void initState() {
    _color = Colors.white;
    _rValue = _color.red.toDouble();
    _gValue = _color.green.toDouble();
    _bValue = _color.blue.toDouble();
  }

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

  void _onSliderColorChange() => setState(() => _color =
      Color.fromRGBO(_rValue.toInt(), _gValue.toInt(), _bValue.toInt(), 1));

  Future _changeColorModal() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child: SimpleDialog(
              title: Text(
                'Set the color values',
                textAlign: TextAlign.center,
              ),
              children: [
                Column(
                  children: [
                    Container(
                      child: ColorSlider(_color.red.toDouble(), Colors.red,
                          (colorValue) {
                        _rValue = colorValue;
                        _onSliderColorChange();
                      }).slider,
                      width: 200,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                    Container(
                      child: ColorSlider(_color.green.toDouble(), Colors.green,
                          (colorValue) {
                        _gValue = colorValue;
                        _onSliderColorChange();
                      }).slider,
                      width: 200,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                    Container(
                      child: ColorSlider(_color.blue.toDouble(), Colors.blue,
                          (colorValue) {
                        _bValue = colorValue;
                        _onSliderColorChange();
                      }).slider,
                      width: 200,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          _onColorChange(Color.fromRGBO(_rValue.toInt(),
                              _gValue.toInt(), _bValue.toInt(), 1));
                          Navigator.pop(context);
                        },
                        child: Text('Save'),
                      ),
                    )
                  ],
                ),
              ],
            ),
            onWillPop: () async => false);
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
          random.nextInt(255), random.nextInt(255), random.nextInt(255), 1)),
      onLongPress: _changeColorModal,
    );
  }
}
