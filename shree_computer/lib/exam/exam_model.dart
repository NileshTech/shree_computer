import 'dart:async';
import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shree_computer/firebase_database/firebase_databse.dart';
import 'exam_details.dart';

class ExamsModel extends ChangeNotifier {
  static String refName = "exams";
  List<ExamDetails> allExams;
  static DatabaseReference getExamsDatabaseRefName() {
    return FirebaseDatabaseUtil().examsRef;
  }

  StreamTransformer examsModelTransformer;

  ExamsModel() {
    allExams = new List<ExamDetails>();
  }

  void handleExamsDataStreamTransform(Event event, EventSink<ExamsModel> sink) {
    //   print("Adding handler for stream transformation in faq model");
    ExamsModel changedExamsModel = ExamsModel.fromSnapshotValue(event.snapshot);
    sink.add(changedExamsModel);
  }

  void initialize() {
    print("Creating the stream transformer for Exams model");
    examsModelTransformer = StreamTransformer<Event, ExamsModel>.fromHandlers(
        handleData: handleExamsDataStreamTransform);
    print("Adding Exams listener");
    FirebaseDatabaseUtil()
        .getModelStreamFromDbReference(
            getExamsDatabaseRefName(), examsModelTransformer)
        .listen((changedData) {
      setChangedExamsData(changedData);
      notifyListeners();
      print("Listeners notified in Exams model!!");
    });
  }

  void setChangedExamsData(ExamsModel changedExamsData) {
    allExams = changedExamsData.allExams;
  }

  ExamsModel.fromSnapshotValue(DataSnapshot examsSnapshot) {
    allExams = new List<ExamDetails>();

    LinkedHashMap fetchedExamsMap = examsSnapshot.value;

    if (fetchedExamsMap != null) {
      for (var exam in fetchedExamsMap.entries) {
        print("Creating model for ${exam.key}");
        // if (Exam.value["is-Exam-under-maintenance"] == 0) {

        ExamDetails playerToAdd =
            getExamDetailsFromSnapshot(exam.value, exam.key);
        allExams.add(playerToAdd);
      }
    }
  }

  ExamDetails getExamDetailsFromSnapshot(dynamic value, dynamic key) {
    ExamDetails updatedExamDetails = new ExamDetails(
      id: key,
      question: value['question'] ?? "",
      option1: value['option1'] ?? "",
      option2: value['option2'] ?? "",
      option3: value['option3'] ?? "",
      option4: value['option4'] ?? "",
      correnctOption: value['connect-option'] ?? "",
    );
    return updatedExamDetails;
  }

  List<ExamDetails> getAllExams() {
    return allExams;
  }
}
