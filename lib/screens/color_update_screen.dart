import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/color.dart';

class ColorUpdateScreen extends StatefulWidget {
Color color;
ColorUpdateScreen(this.color);
  @override
  _ColorUpdateScreenState createState() => _ColorUpdateScreenState();
}

class _ColorUpdateScreenState extends State<ColorUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.color.colorName.toString());
  }
}
