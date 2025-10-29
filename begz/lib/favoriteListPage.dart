import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tehadso/page%20of%20html/PageView.dart';

class FavoritesListPage extends StatefulWidget {
  final List<String> allTitles; // full list of all pages

  const FavoritesListPage({super.key, required this.allTitles});

  @override
  State<FavoritesListPage> createState() => _FavoritesListPageState();
}

class _FavoritesListPageState extends State<FavoritesListPage> {
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    // ✅ Fixed: Consistent status bar configuration
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // white icons
        statusBarBrightness: Brightness.dark, // ✅ Fixed: Changed to dark
      ),
    );
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> _removeFavorite(String title) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites.remove(title);
      prefs.setStringList('favorites', _favorites);
    });
  }

  Future<void> _clearAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites.clear();
      prefs.setStringList('favorites', _favorites);
    });
  }

  void _openStudyPage(String title) {
    // ✅ Use the full list of pages
    final allTitles = widget.allTitles;
    final index = allTitles.indexOf(title);
    if (index != -1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HtmlPageView(startIndex: index, titles: allTitles),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ✅ Fixed: Proper system overlay style
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // white icons
          statusBarBrightness: Brightness.dark, // ✅ Fixed: Explicitly set
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
        title: const Text(
          'ምልክት የተደረጉ ገፆች',
          style: TextStyle(
            fontFamily: 'GeezMahtem',
            color: Color.fromARGB(255, 253, 252, 252),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15, top: 13),
            child: IconButton(
              icon: const Icon(Icons.delete_sweep,
                  color: Colors.white), // ✅ Fixed: Added white color
              onPressed: () {
                if (_favorites.isNotEmpty) {
                  _showClearAllConfirmationDialog();
                }
              },
            ),
          ),
        ],
      ),
      body: _favorites.isEmpty
          ? const Center(
              child: Text(
                'ምንም አልተገኙም።',
                style: TextStyle(fontFamily: 'GeezMahtem', fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final title = _favorites[index];
                return Card(
                  color: const Color.fromARGB(255, 252, 252, 252),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'GeezMahtem',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 48, 45, 44),
                      ),
                      onPressed: () => _removeFavorite(title),
                    ),
                    onTap: () => _openStudyPage(title),
                  ),
                );
              },
            ),
    );
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
          'ምልክት የተደረጉ ገፆች ማጥፋት ትፈልጋለህ?',
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
              _clearAllFavorites();
              Navigator.pop(context);
            },
            child: const Text('አዎ', style: TextStyle(fontFamily: 'GeezMahtem')),
          ),
        ],
      ),
    );
  }
}
