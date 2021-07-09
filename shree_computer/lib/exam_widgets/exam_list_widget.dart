import 'package:flutter/material.dart';
import 'package:shree_computer/exam_helper/exam_details.dart';

class ExamListWidget extends StatefulWidget {
  ExamListWidget(this.currentExam);

  @override
  _ExamListWidgetState createState() => _ExamListWidgetState();

  final ExamDetails currentExam;
}

class _ExamListWidgetState extends State<ExamListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.currentExam.correnctOption),
    );
  }
}
