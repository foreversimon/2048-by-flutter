import 'package:flutter/material.dart';
import './components/background.dart';
import './components//blocks.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double grid = 4;
  double base = 90;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2048'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: centerChildren([
          Background(grid: grid, base: base),
          Blocks(grid: grid, base: base)
        ])
      ),
    );
  }
}

List<Widget> centerChildren (List<Widget> list) {
  List<Widget> newList = [];
  list.forEach((element) {
    newList.add(Center(child: element,));
  });
  return newList;
}