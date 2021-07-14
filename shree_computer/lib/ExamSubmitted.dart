import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shree_computer/main.dart';
import 'package:shree_computer/widgets/app_bar.dart';

class ExamSubmitted extends StatefulWidget {
  const ExamSubmitted({
    Key key,
    @required this.studentName,
    @required this.mobileNumber,
    @required this.city,
  }) : super(key: key);
  final String studentName;
  final String mobileNumber;
  final String city;

  @override
  _ExamSubmittedState createState() => _ExamSubmittedState();
}

class _ExamSubmittedState extends State<ExamSubmitted> {
  @override
  void initState() {
    super.initState();
    addData();
    getMarks();
  }

  bool isButtonPressed = false;
  String marks = "0";
  final databaseRef = FirebaseDatabase.instance.reference();
  void addData() {
    databaseRef
        .child("exam-details")
        .child("student-id")
        .child(widget.mobileNumber)
        .update({
      'name': widget.studentName,
      'mobile-number': widget.mobileNumber,
      'city': widget.city,
    });
  }

  Future<void> getMarks() async {
    await FirebaseDatabase.instance
        .reference()
        .child("exam-details")
        .child("student-id")
        .child(widget.mobileNumber)
        .child("correct-answers")
        .once()
        .then((snapshot) {
      if (snapshot.value != null) {
        marks = snapshot.value.toString();
      } else {
        marks = "0";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screensSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Material(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: screensSize.height * 0.05,
                ),
                appBarContainer(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(thickness: 2, color: Colors.indigo),
                ),
                SizedBox(
                  height: screensSize.height * 0.05,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.indigo.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Student Name"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100.0, left: 100),
                      child: Divider(color: Colors.indigo),
                    ),
                    Text(
                      widget.studentName,
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.av_timer_sharp,
                          color: Colors.indigo.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Marks Obtained")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100.0, left: 100),
                      child: Divider(color: Colors.indigo),
                    ),
                    isButtonPressed
                        ? Text(
                            marks,
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        : MaterialButton(
                            onPressed: () {
                              setState(() {
                                isButtonPressed = true;
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                            child: Text("Click Me see the marks !"),
                          ),
                  ],
                ),
                SizedBox(height: screensSize.height * 0.2),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return new MyHomePage();
                    }));
                  },
                  color: Colors.indigo,
                  splashColor: Colors.indigoAccent[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text("Go to Dashboard",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            )),
      ),
    );
  }
}
