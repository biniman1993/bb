import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

String noteText = '';

class ScrollableListView extends StatefulWidget {
  final int? lastPage; // <-- Add this line

  const ScrollableListView({super.key, this.lastPage}); // <-- Add lastPage here

  @override
  _ScrollableListViewState createState() => _ScrollableListViewState();
}

class _ScrollableListViewState extends State<ScrollableListView> {
  final List<String> titles = [
    'መግቢያ',
    'የሰይጣን ጥረት',
    'የሰይጣን ጥረቱ ውጤት',
    'እውነትን የመልቀቅ ውጤት',
    'ከአላማ መውጣት',
    'ክርስቲያናዊ መልክ በእግዚአብሔር ቃል እውነት ሲታይ',
    'ዘመኑን መዋጀት',
    'በዚህ ዘመን ያለችውን ቤተክርስቲያን ሰይጣን ያታለለበት መንገድ',
    'ያለፈችዋ ቤተክርስቲያን ታሪክ',
    'የእግዚአብሄር የማዳን ፅዋ',
    'የእግዚአብሔር መንግስት ዜግነት ሚስጥር',
    'የዘመኑ ቤተክርስቲያን ስርዓቷና መልኳ',
    'መፅሐፍ ቀዱስ የሚሰጠን ሰማያዊ ስርዓት',
    'የሴቲቱ መናዘዝ',
    'የአዳም አመፅ ወቅት',
    'የፅድቅና የአመፅ ልጆች መወለድ',
    'ከአዳም እስከ እስራኤል ልጆች',
    'ዲቦራና መሳፍንት ዘመን',
    'አሁን ያለንበት ዘመን',
    'ሰይጣን ሄዋንን ያሳተበት ጥበብ',
    'ሴት የባል(የወንድ) ረዳት መሆኗ',
    'ሴቶች በጉባኤ ዝም ይበሉ የመባል ምስጢር',
    'የብሉይና የአዲስ ኪዳን አገልግሎት ልዩነትና አናድነት',
    'የኢዮኤል ትንቢት የመፈፀም ምስጢር',
    'የሚልክያስ ዘመን አገልግሎት',
    'የሔዋን ንስሀ በር መክፈት',
    'የአምስቱ ስጦታዎች አገልግሎት',
    'ከጌታ ኢየሱስ እስከ ቤተክርስቲያን አባቶች',
    'የቀደመችዋ ቤተክርስቲያንና የአሁኗ ቤተክርስቲያን',
    'የተሰጠውን ስጦታ እንደ ቃሉ አለመጠቀም ቅጣት ያመጣል',
    'በእግዚአብሔርና በህዝቡ መሃል የመቆም ምስጢር',
    'አገልጋይና ፀጋው',
    'የእግዚአብሔር ጥሪ',
    'ሽማግሌዋችና ዲያቆናት',
    'እስራኤልና ባህሏ',
    'ማጠቃለያ',
  ];

  final String defaultImage = 'assets/a.jpg';
  List<String> _favoriteTitles = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteTitles = prefs.getStringList('favorites') ?? [];
    });
  }

  void _toggleFavorite(String title) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favoriteTitles.contains(title)) {
        _favoriteTitles.remove(title);
      } else {
        _favoriteTitles.add(title);
      }
      prefs.setStringList('favorites', _favoriteTitles);
    });
  }

  bool _isFavorite(String title) {
    return _favoriteTitles.contains(title);
  }

  String _truncateTitle(String title) {
    const int maxChars = 40;
    if (title.length <= maxChars) return title;
    return '${title.substring(0, maxChars)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Mybar(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 211, 208, 226),
                Color.fromARGB(255, 59, 73, 153),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 6.0),
            child: Text(
              'መነሻ ገፅ',
              style: TextStyle(
                fontFamily: 'GeezMahtem',
                color: Color.fromARGB(255, 253, 252, 252),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        /*actions: [
          SearchIconButton(titles: titles), // ✅ this is correct
          const SizedBox(width: 5),
          IconButton(
            icon: const Icon(Icons.notification_add),
            onPressed: () => showUpdateDialog(context),
            color: Colors.white,
          ),
          const SizedBox(width: 20),
        ],*/
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.4, 1.0],
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 66, 68, 161),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text(
              'በእግዚአብሔር ቃል እውነት መኖር!',
              style: TextStyle(fontFamily: 'GeezMahtem', fontSize: 20),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 4,
                    shadowColor: const Color.fromARGB(255, 2, 2, 2),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    color: index % 2 == 0
                        ? const Color.fromARGB(255, 241, 241, 241)
                        : const Color.fromARGB(255, 245, 244, 247),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          defaultImage,
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        _truncateTitle(titles[index]),
                        style: const TextStyle(
                          fontFamily: 'GeezMahtem',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          _isFavorite(titles[index])
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: _isFavorite(titles[index])
                              ? const Color.fromARGB(255, 80, 79, 79)
                              : const Color.fromARGB(255, 102, 102, 102),
                        ),
                        onPressed: () {
                          _toggleFavorite(titles[index]);
                        },
                      ),
                      onTap: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HtmlPageView(startIndex: index, titles: titles),
                          ),
                        );*/
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showUpdateDialog(BuildContext context) {
  // Telegram launcher function
  Future<void> _openTelegram() async {
    final Uri tgUrl = Uri.parse("tg://resolve?domain=ReformationLife_Join");
    final Uri webUrl = Uri.parse("https://t.me/ReformationLife_Join");

    if (await canLaunchUrl(tgUrl)) {
      await launchUrl(tgUrl, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "UpdateDialog",
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox.shrink(); // UI is in transitionBuilder
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        scale: Curves.easeOutBack.transform(animation.value),
        child: Opacity(
          opacity: animation.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.notifications_active,
                  size: 50,
                  color: Color.fromARGB(255, 73, 79, 114),
                ),
                const SizedBox(height: 12),
                const Text(
                  '✨ ሌሎች መተግበሪያዎችን ይፈልጋሉ?',
                  style: TextStyle(
                    fontFamily: 'GeezMahtem',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'ከታች ያለውን ማስፈንጠርያ ይጫኑ እና ተለግራም ቻናላችን ይቀላቀሉ!!',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'GeezMahtem',
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 73, 79, 114),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  onPressed: _openTelegram,
                  icon: const Icon(Icons.telegram, color: Colors.white),
                  label: const Text(
                    "Join Telegram",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
