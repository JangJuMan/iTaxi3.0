import 'dart:ui';

import 'package:flutter/material.dart';
import 'screen/listpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'itaxi',
      home: TaxiCarList(title: '조회 / 모집'),
    );
  }
}
