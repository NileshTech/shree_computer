import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_computer/exam/exam_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExamsModel>(
      child: Consumer<ExamsModel>(builder: (context, examsModel, child) {
        return Container();
      }),
      create: (BuildContext context) {
        ExamsModel allExamsModel = ExamsModel();
        allExamsModel.initialize();

        return allExamsModel;
      },
    );
  }
}
