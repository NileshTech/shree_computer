import 'package:flutter/material.dart';
import 'package:shree_computer/ExamPage.dart';
import 'package:shree_computer/ExamSubmitted.dart';
import 'package:shree_computer/widgets/app_bar.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class ExamHomePage extends StatefulWidget {
  const ExamHomePage(
      {Key key,
      @required this.studentName,
      @required this.mobileNumber,
      @required this.city})
      : super(key: key);
  final String studentName;
  final String mobileNumber;
  final String city;

  @override
  _ExamHomePageState createState() => _ExamHomePageState();
}

class _ExamHomePageState extends State<ExamHomePage> {
  Duration _duration = const Duration(seconds: 3600);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: Container(
          child: Stack(
            children: [
              // appBarContainer(context),
              Column(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  Expanded(
                    child: appBarContainer(context),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExamPage(
                          studentName: widget.studentName,
                          mobileNumber: widget.mobileNumber,
                          city: widget.city),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                ],
              ),
              Positioned(
                bottom: 50,
                left: 10,
                right: 10,
                child: Container(
                  child: Column(
                    children: [
                      Text("Time Remaining to end the exam"),
                      SlideCountdownClock(
                        duration: _duration,
                        slideDirection: SlideDirection.Up,
                        separator: "-",
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        separatorTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.indigo, shape: BoxShape.circle),
                        onDone: () {
                          Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new ExamSubmitted(
                                studentName: widget.studentName,
                                mobileNumber: widget.mobileNumber,
                                city: widget.city,
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
