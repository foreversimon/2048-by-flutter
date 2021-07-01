import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  final double grid;
  final double base;
  Background ({Key? key, required this.grid, required this.base}) : super(key: key);
  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSize(widget.grid, widget.base),
      height: getSize(widget.grid, widget.base),
      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 204, 1))
    );
  }
}

double getSize (double grid, double base) {
  return grid * base;
}