import 'dart:ui';

import 'package:flutter/material.dart';
import 'screen/listpage.dart';
import 'screen/timelinepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'itaxi',
      home: TimeLine(),
    );
  }
}
