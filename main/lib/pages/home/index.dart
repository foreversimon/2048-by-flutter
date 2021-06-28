import 'package:flutter/material.dart';
import './components/background.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2048'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: centerChildren([
          Background(grid: 4)
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