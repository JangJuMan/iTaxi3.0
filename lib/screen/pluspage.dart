import 'package:flutter/material.dart';

class PlusPage extends StatefulWidget {
  PlusPage({Key key}) : super(key: key);

  @override
  _PlusPageState createState() => _PlusPageState();
}

class _PlusPageState extends State<PlusPage> {
  final locationController = TextEditingController();
  bool is_expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget> [
            Row(
              children: <Widget> [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "직접입력",
                        suffixIcon: Icon(Icons.search)
                    ),
                    controller: locationController,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.location_searching,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    // Get current location
                  },
                )
              ]
            ),
            Column(
              children: <Widget> [
                Row(
                  children: <Widget> [
                    Expanded(child:Text('한동대학교'), flex: 1),
                    Expanded(child:Text('포항역'), flex: 1),
                    Expanded(child:Text('고속버스터미널'), flex: 1)
                  ]
                ),
                Row(
                  children: <Widget> [
                    Expanded(child:Text('하나로마트'), flex: 1),
                    Expanded(child:Text('커피유야'), flex: 1),
                    Expanded(child:Text('세차장'), flex: 1),
                  ]
                ),
                Center(
                  child: IconButton(
                    icon: Icon(is_expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                    onPressed: () {
                      setState(() {
                        is_expanded = !is_expanded;
                      });
                    }
                  )
                )
              ]
            ),
            Divider(),
            Column(
              children: <Widget> [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('최근 검색 기록'),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                  child: Row(
                    children: <Widget> [
                      Expanded(child: Text('한동대학교'), flex: 2),
                      Expanded(child: Divider(), flex: 1),
                      Expanded(child: Text('포항역'), flex: 2),
                    ]
                  )
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                    child: Row(
                        children: <Widget> [
                          Expanded(child: Text('커피유야'), flex: 2),
                          Expanded(child: Divider(), flex: 1),
                          Expanded(child: Text('육거리'), flex: 2),
                        ]
                    )
                )
              ]
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]
        )
      )
    );
  }
}
