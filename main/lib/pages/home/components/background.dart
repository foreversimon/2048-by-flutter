import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  final double grid;
  Background ({Key? key, required this.grid}) : super(key: key);
  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  double base = 90;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSize(widget.grid, base),
      height: getSize(widget.grid, base),
      decoration: BoxDecoration(color: Colors.yellow),
      child: Wrap(
        children: grids(widget.grid, base),
      ),
    );
  }
}

List<Widget> grids (double num, double base) {
  int pow = num.round() * num.round();
  BorderSide borderSide = BorderSide(width: 1, color: Colors.yellowAccent);
  return new List.filled(pow, Container(
    width: base,
    height: base,
    decoration: BoxDecoration(
      border: Border(
        top: borderSide,
        left: borderSide,
        right: borderSide,
        bottom: borderSide
      )
    ),
  ));
}

double getSize (double grid, double base) {
  return grid * base;
}