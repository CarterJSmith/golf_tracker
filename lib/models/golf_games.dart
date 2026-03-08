import 'dart:convert';

class GolfGame {
  final String courseName;
  final int score;
  final String date;

  // Constructor
  GolfGame({
    required this.courseName,
    required this.score,
    required this.date,
  });


  // Converts a GolfGame object into a Map.
  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
      'score': score,
      'date': date,
    };
  }

  // Creates a GolfGame object from a Map.
  factory GolfGame.fromJson(Map<String, dynamic> json) {
    return GolfGame(
      courseName: json['courseName'] as String,
      score: json['score'] as int,
      date: json['date'] as String,
    );
  }

  // Encodes a List of GolfGames into a single JSON String.
  static String encode(List<GolfGame> games) => json.encode(
        games.map<Map<String, dynamic>>((game) => game.toJson()).toList(),
      );

  // Decodes a JSON String back into a List of GolfGames.
  static List<GolfGame> decode(String gamesJson) =>
      (json.decode(gamesJson) as List<dynamic>)
          .map<GolfGame>((item) => GolfGame.fromJson(item))
          .toList();
}