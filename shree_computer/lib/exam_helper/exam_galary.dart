import 'dart:collection';

import 'package:shree_computer/firebase_database/firebase_databse.dart';

class ExamsLibrary {
  String _id;
  String _question;
  String _option1;
  String _option2;
  String _option3;
  String _option4;
  String _correnctOption;

  ExamsLibrary({
    id,
    question,
    option1,
    option2,
    option3,
    option4,
    correnctOption,
  });

  String get id => _id;
  String get question => _question;

  String get option1 => _option1;

  String get option2 => _option2;

  String get option3 => _option3;

  String get option4 => _option4;

  String get correnctOption => _correnctOption;

  ExamsLibrary.fromSnapshot(dynamic snapshot, String key) {
    _id = key;
    _question = snapshot['q'];
    _option1 = snapshot['o1'];
    _option2 = snapshot['o2'];
    _option3 = snapshot['o3'];
    _option4 = snapshot['o4'];
    _correnctOption = snapshot['c'];
  }

  factory ExamsLibrary.fromJson(Map<dynamic, dynamic> parsedJson) {
    return ExamsLibrary(
      id: parsedJson["id"],
      question: parsedJson['q'],
      option1: parsedJson['o1'],
      option2: parsedJson['o2'],
      option3: parsedJson['o3'],
      option4: parsedJson['o4'],
      correnctOption: parsedJson['c'],
    );
  }

  static Future<List<ExamsLibrary>> getAllGames() async {
    var games = await FirebaseDatabaseUtil().examsRef.once();
    List<ExamsLibrary> listOfGames = new List<ExamsLibrary>();
    print(games);
    LinkedHashMap gamesMap = games.value;

    for (var gameLibKey in gamesMap.keys) {
      ExamsLibrary gamesLibrary =
          ExamsLibrary.fromSnapshot(gamesMap[gameLibKey], gameLibKey);
      listOfGames.add(gamesLibrary);
    }

    return listOfGames;
  }
}
