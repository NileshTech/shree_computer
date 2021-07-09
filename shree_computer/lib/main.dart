import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_computer/HomePage.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    Duration _duration = const Duration(seconds: 3600);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Shree Computer"),
        backgroundColor: Colors.indigo,
      ),
      body: Stack(
        children: [
          HomePage(),
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
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    onDone: () {
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text('Clock 1 finished')));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
