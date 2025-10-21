import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> _notes = [];
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes = prefs.getStringList('notes') ?? [];
    });
  }

  Future<void> _saveNote() async {
    if (_noteController.text.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes.add(_noteController.text.trim());
      prefs.setStringList('notes', _notes);
      _noteController.clear();
    });
  }

  Future<void> _removeNote(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes.removeAt(index);
      prefs.setStringList('notes', _notes);
    });
  }

  Future<void> _clearAllNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes.clear();
      prefs.setStringList('notes', _notes);
    });
  }

  void _showClearAllConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'ሁሉንም ይሰርዙ?',
          style: TextStyle(
            fontFamily: 'GeezMahtem',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'ሁሉንም ማስታወሻዎች ማጥፋት ትፈልጋለህ?',
          style: TextStyle(
            fontFamily: 'GeezMahtem',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('አይ', style: TextStyle(fontFamily: 'GeezMahtem')),
          ),
          TextButton(
            onPressed: () {
              _clearAllNotes();
              Navigator.pop(context);
            },
            child: const Text('አዎ', style: TextStyle(fontFamily: 'GeezMahtem')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 31, 38, 87),
                Color.fromARGB(255, 131, 131, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          'ማስታወሻዎች',
          style: TextStyle(
            fontFamily: 'GeezMahtem',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15, top: 13),
            child: IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed:
                  _notes.isNotEmpty ? _showClearAllConfirmationDialog : null,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Notes list
          Expanded(
            child: _notes.isEmpty
                ? const Center(
                    child: Text(
                      'ምንም ማስታወሻዎች አልተገኙም።',
                      style: TextStyle(
                        fontFamily: 'GeezMahtem',
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      final note = _notes[index];
                      final title =
                          note.trim().split(' ').first; // first word as title

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            title,
                            style: const TextStyle(
                              fontFamily: 'GeezMahtem',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            // Show full note in popup when tapped
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor:
                                    Colors.white, // Popup background color
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Title with background
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 70, 75, 112),
                                        // Title background color
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          title,
                                          style: const TextStyle(
                                            fontFamily: 'GeezMahtem',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .white, // Title text color
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Content
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          note,
                                          style: const TextStyle(
                                            fontFamily: 'GeezMahtem',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Close Button
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16, bottom: 12),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 70, 75, 112),
// Button background
                                            foregroundColor:
                                                Colors.white, // Text color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            'Close',
                                            style: TextStyle(
                                              fontFamily: 'GeezMahtem',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 41, 38, 37),
                            ),
                            onPressed: () => _removeNote(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Input field and save button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'ማስታወሻዎን እዚህ ያስገቡ...',
                      hintStyle: const TextStyle(
                        fontFamily: 'GeezMahtem',
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _saveNote,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color.fromARGB(255, 31, 38, 87),
                  ),
                  child: const Text(
                    'አስቀምጥ',
                    style: TextStyle(
                      fontFamily: 'GeezMahtem',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
