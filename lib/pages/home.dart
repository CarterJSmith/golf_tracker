import 'package:flutter/material.dart';
import 'package:golf_tracker/pages/add_game.dart';
import '../models/golf_games.dart';
import '../data/storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StorageService _storage = StorageService();
  List<GolfGame> _games = [];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  // Retrieve games from local storage
  Future<void> _loadGames() async {
    final games = await _storage.getGames();
    setState(() {
      _games = games;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Container(
            height: 200,
            color: const Color.fromARGB(255, 127, 202, 131),
            child: Center(
              child: Image.asset('assets/images/homeIcon.png', fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          const Divider(height: 1, thickness: 2, color: Colors.green),
          // DISPLAY THE LIST
          Expanded(
            child: _games.isEmpty 
              ? const Center(child: Text("No games saved yet!"))
              : ListView.builder(
                  itemCount: _games.length,
                  itemBuilder: (context, index) {
                    final game = _games[index];
                    return ListTile(
                      title: Text(game.courseName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(game.date),
                      trailing: Text('${game.score}', style: const TextStyle(fontSize: 20, color: Colors.green)),
                    );
                  },
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh list when returning from AddGame
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddGame()))
            .then((_) => _loadGames());
        },
        backgroundColor: const Color.fromARGB(255, 80, 145, 83),
        child: const Icon(Icons.add),
      ),
    );
  }
}


AppBar appBar()
{
  return AppBar(
    title: const Text('My Scores',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.green[700],
    
  );
}