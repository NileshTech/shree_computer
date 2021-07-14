import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_computer/ExamSubmitted.dart';
import 'package:shree_computer/exam_helper/exam_details.dart';
import 'package:shree_computer/exam_helper/exam_model.dart';

class ExamPage extends StatefulWidget {
  const ExamPage(
      {Key key,
      @required this.studentName,
      @required this.mobileNumber,
      @required this.city})
      : super(key: key);
  final String studentName;
  final String mobileNumber;
  final String city;
  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int questionNumberIndex = 0;
  int correctAnswers = 0;
  Color option1Color = Colors.indigo;
  Color option2Color = Colors.indigo;
  Color option3Color = Colors.indigo;
  Color option4Color = Colors.indigo;
  int totalNumberOfQuestions;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExamsModel>(
      child: Consumer<ExamsModel>(builder: (context, allExamsModel, child) {
        if (allExamsModel.allExams.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          totalNumberOfQuestions = allExamsModel.allExams.length;
        }

        void checkAnswer(String selctedOption, String correctOption) {
          final databaseRef = FirebaseDatabase.instance.reference();

          if (selctedOption == correctOption) {
            setState(() {
              correctAnswers += 1;
              databaseRef
                  .child("exam-details")
                  .child("student-id")
                  .child(widget.mobileNumber)
                  .update({'correct-answers': correctAnswers});
            });
          } else {
            print("wrong answer selected");
          }
        }

        Widget choiceButton1(String option, String correctOption) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
            child: MaterialButton(
              // height: screenSize.height * 0.05,
              onPressed: () {
                setState(() {
                  option1Color = Colors.green;
                  option2Color = Colors.indigo;
                  option3Color = Colors.indigo;
                  option4Color = Colors.indigo;
                });

                checkAnswer(option, correctOption);
              },
              child: Text(
                option,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: option1Color,
              splashColor: Colors.indigoAccent[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          );
        }

        Widget choiceButton2(String option, String correctOption) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
            child: MaterialButton(
              // height: screenSize.height * 0.05,
              onPressed: () {
                setState(() {
                  option1Color = Colors.indigo;
                  option2Color = Colors.green;
                  option3Color = Colors.indigo;
                  option4Color = Colors.indigo;
                });
                checkAnswer(option, correctOption);
              },
              child: Text(
                option,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: option2Color,
              splashColor: Colors.indigoAccent[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          );
        }

        Widget choiceButton3(String option, String correctOption) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
            child: MaterialButton(
              // height: screenSize.height * 0.05,
              onPressed: () {
                setState(() {
                  option1Color = Colors.indigo;
                  option2Color = Colors.indigo;
                  option3Color = Colors.green;
                  option4Color = Colors.indigo;
                });
                checkAnswer(option, correctOption);
              },
              child: Text(
                option,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: option3Color,
              splashColor: Colors.indigoAccent[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          );
        }

        Widget choiceButton4(String option, String correctOption) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
            child: MaterialButton(
              // height: screenSize.height * 0.05,
              onPressed: () {
                setState(() {
                  option1Color = Colors.indigo;
                  option2Color = Colors.indigo;
                  option3Color = Colors.indigo;
                  option4Color = Colors.green;
                });
                checkAnswer(option, correctOption);
              },
              child: Text(
                option,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: option4Color,
              splashColor: Colors.indigoAccent[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          );
        }

        Widget examWidget(BuildContext context, ExamDetails currentExam) {
          int questionNumber = questionNumberIndex + 1;
          return Column(
            children: [
              Divider(
                thickness: 2,
                color: Colors.indigo,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Que No. " + questionNumber.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Material(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      currentExam.question,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      choiceButton1(
                          currentExam.option1, currentExam.correnctOption),
                      choiceButton2(
                          currentExam.option2, currentExam.correnctOption),
                      choiceButton3(
                          currentExam.option3, currentExam.correnctOption),
                      choiceButton4(
                          currentExam.option4, currentExam.correnctOption),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    child: Container(
                      child: questionNumberIndex == 0
                          ? Container(
                              alignment: Alignment.centerRight,
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    option1Color = Colors.indigo;
                                    option2Color = Colors.indigo;
                                    option3Color = Colors.indigo;
                                    option4Color = Colors.indigo;
                                    questionNumberIndex =
                                        questionNumberIndex + 1;
                                  });
                                },
                                color: Colors.red,
                                splashColor: Colors.indigoAccent[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  "Next",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : questionNumberIndex != (totalNumberOfQuestions - 1)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
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
                                      color: Colors.red,
                                      splashColor: Colors.indigoAccent[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        "End Exam",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          option1Color = Colors.indigo;
                                          option2Color = Colors.indigo;
                                          option3Color = Colors.indigo;
                                          option4Color = Colors.indigo;
                                          questionNumberIndex =
                                              questionNumberIndex + 1;
                                        });
                                      },
                                      color: Colors.red,
                                      splashColor: Colors.indigoAccent[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        "Next",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : MaterialButton(
                                  onPressed: () {
                                    print(widget.studentName);
                                    Navigator.of(context).pushReplacement(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return new ExamSubmitted(
                                        studentName: widget.studentName,
                                        mobileNumber: widget.mobileNumber,
                                        city: widget.city,
                                      );
                                    }));
                                  },
                                  color: Colors.red,
                                  splashColor: Colors.indigoAccent[700],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.indigo,
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              examWidget(
                context,
                allExamsModel.allExams[questionNumberIndex],
              ),
            ],
          ),
        );
      }),
      create: (BuildContext context) {
        ExamsModel allExamsModel = ExamsModel();
        allExamsModel.initialize();

        return allExamsModel;
      },
    );
  }
}
