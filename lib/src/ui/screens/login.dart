import 'package:centillion/src/managers/user_manager.dart';
import 'package:centillion/src/models/user_model.dart';
import 'package:centillion/src/ui/widgets/home_painter.dart';
import 'package:centillion/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight(context, dividedBy: 1),
          child: CustomPaint(
            painter: CurvePainter(),
            child: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Hello',
                          style: TextStyle(
                              fontSize: 52, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Sign in to your account',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.mail,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide(color: Colors.grey))),
                          validator: ((value) =>
                              formValidator(value, 'Please enter email')),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toggle the state of passwordVisible variable
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide(color: Colors.grey))),
                          obscureText: !passwordVisible,
                          validator: ((value) =>
                              formValidator(value, 'Please enter password')),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                // positioning a custom design on the screen with centillion logo icon
                // currently logo icon is not available
                Positioned(
                    right: -22,
                    top: screenHeight(context, dividedBy: 16),
                    child: CircleAvatar(
                      radius: screenHeight(context, dividedBy: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(colors: [
                                Color(0xFF3B5D79),
                                Color(0xFF3A5C78),
                                Color(0xFF1F354A),
                              ]))),
                    )),

                // positioning the SignIn button to the bottom of the screen
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Sign in',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                          margin: EdgeInsets.only(left: 4),
                          width: screenWidth(context, dividedBy: 6),
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            gradient: new LinearGradient(
                              colors: [Color(0xFFFA4616), Color(0xFFFF7A57)],
                            ),
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 38,
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                var _isUser = user.authUser(UserModel(
                                    email: _emailController.text
                                        .trim()
                                        .toLowerCase(),
                                    password: _passwordController.text
                                        .trim()
                                        .toLowerCase()));

                                if (_isUser) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                } else {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _emailController.clear();
                                  _passwordController.clear();
                                  showToast('User not found');
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  bottom: 32,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // function to validate the email & password input
  formValidator(String val, String errMsg) {
    if (val.isEmpty) {
      return errMsg;
    }
    return null;
  }
}
