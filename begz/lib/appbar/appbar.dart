import 'package:flutter/material.dart';
import 'package:tehadso/aboutUsScreen.dart';
import 'package:tehadso/about_developer_screen.dart';
import 'package:tehadso/call_us_page.dart';
import 'package:tehadso/emailUsScreen.dart';
import 'package:tehadso/favoriteListPage.dart';
import 'package:tehadso/favourit.dart';
import 'package:tehadso/note.dart';
import 'package:tehadso/rateapp.dart';
import 'package:tehadso/share_app_page.dart';
import 'package:tehadso/showExitDialog.dart';
import 'package:tehadso/socialmedia.dart';

class Mybar extends StatelessWidget {
  Mybar({super.key});
  final List<String> myTitlesList = [
    'መግቢያ',
    'የሰይጣን ጥረት',
    'የሰይጣን ጥረቱ ውጤት',
    'እውነትን የመልቀቅ ውጤት',
    'ከአላማ መውጣት',
    'ክርስቲያናዊ መልክ በእግዚአብሄር ቃል እውነት ሲታይ',
    'ዘመኑን መዋጀት',
    'በዚህ ዘመን ያለችውን ቤተክርስቲያን ሰይጣን ያታለለበት መንገድ',
    'ያለፈችዋ ቤተክርስቲያን ታሪክ',
    'የእግዚአብሄር የማዳን ፅዋ',
    'የእግዚአብሄር መንግስት ዜግነት ሚስጥር',
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
    'በእግዚአብሄርና በህዝቡ መሃል የመቆም ምስጢር',
    'አገልጋይና ፀጋው',
    'የእግዚአብሄር ጥሪ',
    'ሽማግሌዋችና ዲያቆናት',
    'እስራኤልና ባህሏ',
    'ማጠቃለያ',
  ];
  @override
  Widget build(BuildContext context) {
    // TextStyle for Gezamen font
    const TextStyle gezamenStyle = TextStyle(
      fontFamily: 'GeezMahtem',
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(''),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/app.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Real Navigation Items
          ListTile(
            leading: const Icon(Icons.info_sharp),
            title: const Text('ስለ ትምህርቱ', style: gezamenStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('የተወደዱ ትምህርቶች', style: gezamenStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesPage(titles: myTitlesList),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('ምልክት የተደረጉ ገፆች', style: gezamenStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesListPage(allTitles: myTitlesList),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.note_alt), // use a note icon
            title: const Text(
              'ማስታወሻዎች',
              style: gezamenStyle, // your text style
            ),
            onTap: () {
              Navigator.pop(context); // close the drawer or previous screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const NotesPage()), // call your NotesPage
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('ማህበራዊ መገናኛ', style: gezamenStyle),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SocialMediaScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('መተግበሪያ አጋራ', style: gezamenStyle),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ShareAppPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('እኛን ለማገኘት', style: gezamenStyle),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CallUsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('ኢሜል ይላኩልን', style: gezamenStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EmailUsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: const Text('መተግበሪያ ይምረጡ', style: gezamenStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RateAppScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('ስለ መተግበሪያ', style: gezamenStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutDeveloperScreen()),
              );
            },
          ),
          // Exit
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('ውጣ', style: gezamenStyle),
            onTap: () {
              showExitDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
