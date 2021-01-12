import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisiable = false;
  bool _passwordCheckVisiable = false;
  bool _agree1 = false;
  bool _agree2 = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var _blankFocusnode = new FocusNode();

  TextEditingController _stuIdCon = TextEditingController();
  TextEditingController _stuIdCheckCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  TextEditingController _pwCheckCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
          onTap: () {
            // Navigate
          },
        ),
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )
        )
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_blankFocusnode);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Student ID",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _stuIdCon,
                      decoration: InputDecoration(
                        hintText: "Enter your student ID",
                        helperText: " ",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty ? "Enter your student ID" : null;
                      },
                    )
                  ),
                  Text(
                    "Student ID Check",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _stuIdCheckCon,
                      decoration: InputDecoration(
                        hintText: "Enter your student ID one more",
                        helperText: " ",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return "Enter your student ID";
                        else if (_stuIdCon.text != value)
                          return "Enter your student ID correctly";
                        else
                          return null;
                      },
                    )
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      obscureText: !_passwordVisiable,
                      keyboardType: TextInputType.number,
                      controller: _pwCon,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        helperText: " ",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisiable ? Icons.visibility : Icons.visibility_off,
                            color: _passwordVisiable ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisiable = !_passwordVisiable;
                            });
                          },
                        )
                      ),
                      validator: (value) {
                        return value.isEmpty ? "Enter your password" : null;
                      },
                    )
                  ),
                  Text(
                    "Password Check",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _pwCheckCon,
                      decoration: InputDecoration(
                        hintText: "Enter your password one more",
                        helperText: " ",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordCheckVisiable ? Icons.visibility : Icons.visibility_off,
                            color: _passwordCheckVisiable ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordCheckVisiable = !_passwordCheckVisiable;
                            });
                          },
                        )
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return "Enter your password";
                        else if (_pwCon.text != value)
                          return "Enter your password correctly";
                        else
                          return null;
                      },
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      RawMaterialButton(
                        child: Text(
                          '이용약관 보기',
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          )
                        ),
                        onPressed: () {
                          // Navigate
                        },
                      ),
                      Row(
                        children: [
                          Text('약관에 동의합니다'),
                          Checkbox(
                            value: _agree1,
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              setState(() {
                                _agree1 = !_agree1;
                              });
                            }
                          )
                        ],
                      ),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      RawMaterialButton(
                        child: Text(
                          '개인정보처리방침 보기',
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          )
                        ),
                        onPressed: () {
                          // Navigate
                        },
                      ),
                      Row(
                        children: [
                          Text('약관에 동의합니다'),
                          Checkbox(
                            value: _agree2,
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              setState(() {
                                _agree2 = !_agree2;
                              });
                            }
                          )
                        ],
                      ),
                    ]
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            // _signUp();
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            )
                          )
                        ),
                      )
                    ]
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}