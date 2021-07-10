import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shree_computer/main.dart';

class ExamSubmitted extends StatefulWidget {
  const ExamSubmitted(
      {Key key,
      @required this.studentName,
      @required this.mobileNumber,
      @required this.city})
      : super(key: key);
  final String studentName;
  final String mobileNumber;
  final String city;

  @override
  _ExamSubmittedState createState() => _ExamSubmittedState();
}

class _ExamSubmittedState extends State<ExamSubmitted> {
  final databaseRef = FirebaseDatabase.instance.reference();
  void addData(String name, String mobileNumber, String city) {
    databaseRef
        .child("exam-details")
        .child("student-id")
        .child(mobileNumber)
        .push()
        .set({
      'name': name,
      'mobile-number': mobileNumber,
      'city': city,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Student Name:"),
                  Text(widget.studentName),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  addData(widget.studentName, widget.mobileNumber, widget.city);
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new MyHomePage();
                  }));
                },
                child: Text("Go to Dashboard"),
              ),
            ],
          )),
    );
  }
}
