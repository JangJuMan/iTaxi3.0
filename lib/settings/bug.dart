import 'package:flutter/material.dart';

class Bug extends StatelessWidget {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text ('버그 제보', style: TextStyle(color: Colors.black),),
      ),
    );
  }
}