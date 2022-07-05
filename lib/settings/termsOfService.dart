import 'package:flutter/material.dart';

class TermsOfService extends StatelessWidget {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text ('이용약관', style: TextStyle(color: Colors.black), ),
      ),
    );
  }
}