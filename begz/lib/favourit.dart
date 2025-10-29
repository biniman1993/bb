import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tehadso/page%20of%20html/PageView.dart';

class FavoritesPage extends StatefulWidget {
  final List<String> titles;

  const FavoritesPage({super.key, required this.titles});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<bool> pageFavourites;

  @override
  void initState() {
    super.initState();
    // Make status bar icons white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.light, // white icons
        statusBarBrightness:
            Brightness.dark, // ✅ Changed to dark for consistency
      ),
    );

    pageFavourites = List.generate(widget.titles.length, (_) => false);
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favourites');
    if (favList != null && favList.length == widget.titles.length) {
      setState(() {
        pageFavourites = favList.map((e) => e == '1').toList();
      });
    }
  }

  Future<void> saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = pageFavourites.map((f) => f ? '1' : '0').toList();
    await prefs.setStringList('favourites', favList);
  }

  void clearAllFavorites() async {
    setState(() {
      pageFavourites = List.generate(widget.titles.length, (_) => false);
    });
    await saveFavourites();
  }

  void removeFavorite(int index) async {
    setState(() {
      pageFavourites[index] = false;
    });
    await saveFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteIndexes = <int>[];
    for (int i = 0; i < pageFavourites.length; i++) {
      if (pageFavourites[i]) favoriteIndexes.add(i);
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // white icons
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        title: const Text(
          "የተወደዱ ትምህርቶች",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'GeezMahtem',
          ),
        ),
        centerTitle: true, // ✅ Added for consistency
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
        backgroundColor: Colors.transparent, // ✅ Added for consistency
        actions: [
          if (favoriteIndexes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 31),
              child: IconButton(
                icon: const Icon(Icons.delete_forever, color: Colors.white),
                tooltip: "Clear All",
                onPressed: clearAllFavorites,
              ),
            ),
        ],
      ),
      body: favoriteIndexes.isEmpty
          ? const Center(
              child: Text(
                "No favorites yet",
                style: TextStyle(fontSize: 18, fontFamily: 'GeezMahtem'),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoriteIndexes.length,
              itemBuilder: (context, index) {
                final i = favoriteIndexes[index];
                return Card(
                  color: const Color.fromARGB(255, 252, 252, 252),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    title: Text(
                      widget.titles[i],
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'GeezMahtem',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 31, 30, 30),
                      ),
                      onPressed: () => removeFavorite(i),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HtmlPageView(
                            titles: widget.titles,
                            startIndex: i,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
