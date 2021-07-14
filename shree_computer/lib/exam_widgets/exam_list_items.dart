import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExamsDisplayListItem extends StatefulWidget {
  final String questionNo;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String correctAnswer;

  ExamsDisplayListItem({
    Key key,
    this.questionNo,
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.correctAnswer,
  }) : super(key: key);

  @override
  _ExamsDisplayListItemState createState() => _ExamsDisplayListItemState();
}

class _ExamsDisplayListItemState extends State<ExamsDisplayListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.question),
      ),
    );
  }
}
