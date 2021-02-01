import 'package:flutter/material.dart';

class PlusPage extends StatefulWidget {
  PlusPage({Key key}) : super(key: key);

  @override
  _PlusPageState createState() => _PlusPageState();
}

// final placesSelected = TextEditingController();
// String selectPlace = "";

class _PlusPageState extends State<PlusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(50.0),
              child: Text("hi", style: TextStyle(color: Colors.blueAccent, fontSize: 15),textAlign: TextAlign.center,),
              // child: DropDownField(
              //   controller: placesSelected,
              //   hintText: "출발",
              //   enabled: true,
              //   items: places,
              //   itemsVisibleInDropdown: 5,
              //   onValueChanged: (value) {
              //     setState(() {
              //       selectPlace = value;
              //     });
              //   },
              // ),
            ),
          ],
        )
    );
  }
}


