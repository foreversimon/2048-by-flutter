import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Blocks extends StatefulWidget {
  final double grid;
  final double base;

  Blocks ({Key? key, required this.grid, required this.base}) : super(key: key);

  @override
  _BlocksState createState() => _BlocksState();
}

class _BlocksState extends State<Blocks> {
  
  List<Widget> grid = [];

  List<List<double>> map = [];

  var timer;

  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    if (map.length == 0) {
      int len = widget.grid.round();
      int i = len;
      while (i > 0) {
        List<double> row = List.filled(len, 0);
        map.add(row);
        i--;
      }

      Random rng = new Random();
      int random (int target) {
        int newRandom = rng.nextInt(widget.grid.round());
        if (newRandom == target) {
          return random(target);
        }
        return newRandom;
      };
      int x1 = rng.nextInt(widget.grid.round());
      int x2 = random(x1);
      int y1 = rng.nextInt(widget.grid.round());
      int y2 = random(y1);
      map[x1][y1] = 2;
      map[x2][y2] = 2;
    }
    grid = getGrids(widget.base, map);
    return Container(
      width: getSize(widget.grid, widget.base),
      height: getSize(widget.grid, widget.base),
      child: GestureDetector(
        onPanStart: (DragStartDetails details) {
          x = details.globalPosition.dx;
          y = details.globalPosition.dy;
        },
        onPanUpdate: (DragUpdateDetails details) {
          timer?.cancel();
          timer = Timer(Duration(milliseconds: 100), () {
            double nowX = details.globalPosition.dx;
            double nowY = details.globalPosition.dy;
            double changeX = nowX - x;
            double changeY = nowY - y;
            String direction = 'right';
            if (changeY.abs() > changeX.abs()) {
              if (changeY > 0) {
                direction = 'bottom';
              } else {
                direction = 'top';
              }
            } else {
              if (changeX > 0) {
                direction = 'right';
              } else {
                direction = 'left';
              }
            }
            print(direction);
            setState(() {
              try {
                map = changeMap(origin: map, direction: direction);
              } catch (e) {
                Fluttertoast.showToast(
                  msg: "Game over",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
                );
              }
            });
          });
        },
        child: Wrap(
          children: grid,
        ),
      )
    );
  }
}

List<Widget> getGrids (double base, List<List<double>> list) {
  List<Widget> newList = [];
  list.forEach((item) => {
    item.forEach((element) {
      String value = '';
      if (element != 0) {
        value = '$element';
      }
      newList.add(Container(
        width: base,
        height: base,
        alignment: Alignment.center,
        child: Text('$value'),
        decoration: BoxDecoration(color: Colors.yellow, border: Border.all(width: 1, color: Colors.yellowAccent)),
      ));
    })
  });
  return newList;
}

double getSize (double grid, double base) {
  return grid * base;
}

List<List<double>> changeMap ({required List<List<double>> origin, required String direction}) {
  List<List<double>> list = [];
  origin.forEach((element) {
    List<double> tmpList = [];
    element.forEach((val) {
      tmpList.add(val);
    });
    list.add(tmpList);
  });
  switch (direction) {
    case 'top':
      for (int i = list.length - 1; i > 0; i--) {
        for (int j = 0; j < list[i].length; j++) {
          for (int d = list.length - 1; d > 0; d--) {
            double top = list[d - 1][j];
            double now = list[d][j];
            if (top == 0 || now == top) {
              list[d - 1][j] = top + now;
              list[d][j] = 0;
            }
          }
        }
      }
      break;
    case 'bottom':
      for (int i = 0; i < list.length - 1; i++) {
        for (int j = 0; j < list[i].length; j++) {
          for (int d = 0; d < list.length - 1; d++) {
            double bottom = list[d + 1][j];
            double now = list[d][j];
            if (bottom == 0 || now == bottom) {
              list[d + 1][j] = bottom + now;
              list[d][j] = 0;
            }
          }
        }
      }
      break;
    case 'left':
      for (int i = 0; i < list.length; i++) {
        for (int j = list[i].length - 1; j > 0; j--) {
          for (int d = 0; d < list.length; d++) {
            double left = list[d][j - 1];
            double now = list[d][j];
            if (left == 0 || now == left) {
              list[d][j - 1] = left + now;
              list[d][j] = 0;
            }
          }
        }
      }
      break;
    case 'right':
      for (int i = 0; i < list.length; i++) {
        for (int j = 0; j < list[i].length - 1; j++) {
          for (int d = 0; d < list.length; d++) {
            double right = list[d][j + 1];
            double now = list[d][j];
            if (right == 0 || now == right) {
              list[d][j + 1] = right + now;
              list[d][j] = 0;
            }
          }
        }
      }
      break;
  }
  List<int> random () {
    List<List<int>> map = [];
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list[i].length; j++) {
        if (list[i][j] == 0) {
          map.add([i, j]);
        }
      }
    }
    if (map.length < 1) {
      throw Error();
    }
    Random rng = new Random();
    return map[rng.nextInt(map.length)];
  }
  List<int> randomData = random();
  list[randomData[0]][randomData[1]] = 2;
  return list;
}