import 'package:flutter/material.dart';
import 'package:itaxi/customPageRoutes.dart';
import 'package:itaxi/screen/listpage.dart';
import 'package:itaxi/signInUp/signUp.dart';
import 'package:itaxi/main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool passwordVisiable = false;
  bool isBtnPressed = false;
  bool idRemember = false;

  final _formKey = GlobalKey<FormState>();
  var _blankFocusnode = new FocusNode();

  // TODO: 기능추가
  bool _loginCheck(){
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(_blankFocusnode);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(right: 10),
                        // child: Text("Logo"),
                        child: Image.asset('assets/images/logo_main.png')
                      )
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "iTaxi",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 70,
                          )
                        ),
                        Text(
                          "Powered by CRA",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          )
                        ),
                      ]
                    )
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Your custom ID",
                              labelText: "Custom ID",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )
                          ),
                          validator: (value) {
                            return value.isEmpty ? "Enter your hisnet ID" : null;
                          },
                        ),
                        TextFormField(
                            obscureText: !passwordVisiable,
                            decoration: InputDecoration(
                                hintText: "Your custom PW",
                                labelText: "Custom PW",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordVisiable ? Icons.visibility : Icons.visibility_off,
                                    color: passwordVisiable ? Colors.blue : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisiable = !passwordVisiable;
                                    });
                                  },
                                )
                            ),
                            validator: (value) {
                              return value.isEmpty ? "Enter your hisnet PW" : null;
                            }
                        ),
                        /*
                        IconButton(
                          icon: !isBtnPressed ? Image.asset('assets/images/btn_google_login.png') : Image.asset('assets/images/btn_google_login_pressed.png'),
                          onPressed: () {
                            setState((){isBtnPressed = !isBtnPressed;});
                          },
                        )
                        */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Remember ID',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Checkbox(
                                  value: idRemember,
                                  activeColor: Colors.blue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      idRemember = value;
                                    });
                                  }
                                )
                              ]
                            ),
                            RawMaterialButton(
                              child: Text(
                                'Find PW',
                                style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onPressed: () {
                                // Navigate
                              },
                            )
                          ]
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: <Widget> [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget> [
                                ButtonTheme(
                                  minWidth: 200,
                                  height: 50,
                                  child: RaisedButton(
                                    color: Colors.blue,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                        color: Colors.blue,
                                      )
                                    ),
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      if(_loginCheck()){
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => TaxiCarList()));
                                        // Navigator.push(context, BouncyPageRoute(widget: TaxiCarList()),);
                                        // Navigator.of(context).push(FadeInOutPageRoute(TaxiCarList()));


                                        Navigator.of(context).push(FadeInOutPageRoute(TapMenus()));
                                      }
                                      // _signIn();
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      )
                                    )
                                  )
                                )
                              ]
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                // Navigate
                                Navigator.pushNamed(context, 'SignUp');
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  decoration: TextDecoration.underline,
                                )
                              )
                            )
                          ]
                        )
                      ]
                    )
                  )
                )
              ]
            )
        )
      )
    );
  }
}
