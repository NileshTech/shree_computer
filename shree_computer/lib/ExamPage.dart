import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_computer/ExamSubmitted.dart';
import 'package:shree_computer/exam_helper/exam_details.dart';
import 'package:shree_computer/exam_helper/exam_model.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider<ExamsModel>(
      child: Consumer<ExamsModel>(builder: (context, allExamsModel, child) {
        if (allExamsModel.allExams.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        void checkAnswer(String selctedOption, String correctOption) {
          if (selctedOption == correctOption) {
            setState(() {
              correctAnswers += 1;
            });
          } else {
            print("wrong answer selected");
          }
        }

        Widget choiceButton(String option, String correctOption) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
            child: MaterialButton(
              // height: screenSize.height * 0.05,
              onPressed: () => checkAnswer(option, correctOption),
              child: Text(
                option,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.indigo,
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
                      choiceButton(
                          currentExam.option1, currentExam.correnctOption),
                      choiceButton(
                          currentExam.option2, currentExam.correnctOption),
                      choiceButton(
                          currentExam.option3, currentExam.correnctOption),
                      choiceButton(
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
                          : questionNumberIndex != 32
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          questionNumberIndex =
                                              questionNumberIndex - 1;
                                        });
                                      },
                                      color: Colors.red,
                                      splashColor: Colors.indigoAccent[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        "Previous",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        setState(() {
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
                                          correctAnswers: correctAnswers);
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
