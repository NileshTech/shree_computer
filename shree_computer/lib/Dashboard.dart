import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shree_computer/ExamHomePage.dart';
import 'package:shree_computer/widgets/app_bar.dart';
// import 'package:uuid/uuid.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final nameTextcontroller = TextEditingController();
  final mobileTextcontroller = TextEditingController();
  final cityTextcontroller = TextEditingController();
  bool _validateMobileNoIsEmpty = false;
  bool _validateMobileNoIsIncomplete = false;
  String studentName;

  @override
  Widget build(BuildContext context) {
    Size screensSize = MediaQuery.of(context).size;
    // var uuid = Uuid().v4();
    // String studentId = uuid;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screensSize.height * 0.05,
                  ),
                  appBarContainer(context),
                  Divider(thickness: 2, color: Colors.indigo),
                  SizedBox(
                    height: screensSize.height * 0.05,
                  ),
                  Text(
                    "Fill the following form",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(width: 2, color: Colors.blueAccent)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Material(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Student Name",
                                  hintText: "Student Name",
                                  icon: Icon(Icons.account_circle_outlined),
                                  // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                ),
                                controller: nameTextcontroller,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Material(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Mobile Number",
                                  hintText: "Mobile Number",
                                  icon: Icon(Icons.phone_iphone),
                                  errorText: _validateMobileNoIsEmpty
                                      ? 'Value Can\'t Be Empty'
                                      : _validateMobileNoIsIncomplete
                                          ? 'Please enter 10 digit mobile number'
                                          : null,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: mobileTextcontroller,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Material(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "City",
                                  hintText: "City",
                                  icon: Icon(Icons.location_city),
                                  // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                ),
                                controller: cityTextcontroller,
                              ),
                            ),
                          ),
                          Center(
                            child: RaisedButton(
                                color: Colors.indigo,
                                child: Text(
                                  "Start Exam",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (mobileTextcontroller.text.isEmpty) {
                                    setState(() {
                                      mobileTextcontroller.text.isEmpty
                                          ? _validateMobileNoIsEmpty = true
                                          : _validateMobileNoIsEmpty = false;
                                    });
                                  } else {
                                    if (mobileTextcontroller.text.length !=
                                        10) {
                                      setState(() {
                                        _validateMobileNoIsIncomplete = true;
                                      });
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return new ExamHomePage(
                                              studentName:
                                                  nameTextcontroller.text,
                                              mobileNumber:
                                                  mobileTextcontroller.text,
                                              city: cityTextcontroller.text);
                                        }),
                                      );
                                    }
                                  }
                                }),
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
      ),
    );
  }
}
