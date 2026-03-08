import 'package:shared_preferences/shared_preferences.dart';
import '../models/golf_games.dart';

class StorageService {
  static const String _key = 'golf_rounds';

  //Get all games from storage
  Future<List<GolfGame>> getGames() async {
    final prefs = await SharedPreferences.getInstance();
    final String? gamesJson = prefs.getString(_key);
    
    if (gamesJson == null) return [];
    
    return GolfGame.decode(gamesJson);
  }

  //Overwrite the storage with a new list
  Future<void> saveGames(List<GolfGame> games) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = GolfGame.encode(games);
    
    await prefs.setString(_key, encodedData);
  }
}