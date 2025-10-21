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
        statusBarBrightness: Brightness.light,
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "የተወደዱ ትምህርቶች  ",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'GeezMahtem',
          ),
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
                'ምንም አልተገኙም።',
                style: TextStyle(fontSize: 18, fontFamily: 'GeezMahtem'),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoriteIndexes.length,
              itemBuilder: (context, index) {
                final i = favoriteIndexes[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    title: Text(
                      widget.titles[i],
                      style: const TextStyle(
                        fontSize: 18,
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
