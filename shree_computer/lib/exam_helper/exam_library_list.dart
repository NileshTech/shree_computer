import 'package:shree_computer/exam_helper/exam_galary.dart';

class ExamsLibraryList {
  List<ExamsLibrary> gamesList;

  ExamsLibraryList({this.gamesList});

  factory ExamsLibraryList.fromJSON(Map<dynamic, dynamic> json) {
    return ExamsLibraryList(gamesList: parseGames(json));
  }

  static List<ExamsLibrary> parseGames(Map json) {
    var gList = json['games-library'] as List;
    List<ExamsLibrary> gamesListToSend =
        gList.map((data) => ExamsLibrary.fromJson(data)).toList(); //Add this
    return gamesListToSend;
  }
}
