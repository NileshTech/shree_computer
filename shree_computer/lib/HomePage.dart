import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_computer/exam_helper/exam_details.dart';
import 'package:shree_computer/exam_helper/exam_model.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int questionNumberIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExamsModel>(
      child: Consumer<ExamsModel>(builder: (context, allExamsModel, child) {
        if (allExamsModel.allExams.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        Color colorToShow = Colors.indigo;
        Color colorForSelectedOption = Colors.green;

        void checkAnswer(String selctedAnswer) {}
        Widget choiceButton(String option) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: MaterialButton(
              onPressed: () => checkAnswer(option),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Que No. " + questionNumber.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(currentExam.question),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    choiceButton(currentExam.option1),
                    choiceButton(currentExam.option2),
                    choiceButton(currentExam.option3),
                    choiceButton(currentExam.option4),
                  ],
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
                                  child: Text("Next")),
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
                                      child: Text("Previous"),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          questionNumberIndex =
                                              questionNumberIndex + 1;
                                        });
                                      },
                                      child: Text("Next"),
                                    ),
                                  ],
                                )
                              : MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      questionNumberIndex =
                                          questionNumberIndex - 1;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text("Submit"),
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              )
            ],
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                examWidget(
                  context,
                  allExamsModel.allExams[questionNumberIndex],
                ),
              ],
            ),
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
