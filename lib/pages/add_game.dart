import 'package:flutter/material.dart';
import '../models/golf_games.dart';
import '../data/storage_service.dart';

class AddGame extends StatefulWidget {
  const AddGame({super.key});

  @override
  State<AddGame> createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  final _courseController = TextEditingController();
  final _scoreController = TextEditingController();
  final _storage = StorageService();
  String _selectedDate = DateTime.now().toString().split(' ')[0];

  void _saveAndExit() async {
    if (_courseController.text.isEmpty || _scoreController.text.isEmpty) return;

    // 1. Read existing
    List<GolfGame> currentGames = await _storage.getGames();

    // 2. Modify (Create new game)
    GolfGame newGame = GolfGame(
      courseName: _courseController.text,
      score: int.tryParse(_scoreController.text) ?? 0,
      date: _selectedDate,
    );
    currentGames.add(newGame);

    // 3. Save & Return
    await _storage.saveGames(currentGames);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          _buildTextField(_courseController, 'Course Name'),
          _buildTextField(_scoreController, 'Score', isNumber: true),
          
          // Date Picker trigger
          ListTile(
            title: Text("Date: $_selectedDate"),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() => _selectedDate = picked.toString().split(' ')[0]);
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveAndExit,
        backgroundColor: const Color.fromARGB(255, 80, 145, 83),
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }
}

AppBar appBar()
{
  return AppBar(
    title: const Text('Add a Game',
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