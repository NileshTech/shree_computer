import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shree_computer/widgets/app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final nameTextcontroller = TextEditingController();
    final passwordTextcontroller = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Material(
            child: Column(
              children: [
                SizedBox(
                    height: screenSize.height * 0.3,
                    child: appBarContainer(context)),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                SizedBox(
                  height: screenSize.height * 0.55,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.05,
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.05,
                          child: Text(
                            "Login to your account",
                            // style: TextStyle(
                            //     fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Email Id",
                                  hintText: "Email Id",
                                  icon: Icon(Icons.account_circle_outlined),
                                  // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                ),
                                controller: nameTextcontroller,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Password",
                                  hintText: "Password",
                                  icon: Icon(Icons.shield),
                                  // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                ),
                                controller: passwordTextcontroller,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
