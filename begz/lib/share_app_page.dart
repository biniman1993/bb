import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareAppPage extends StatelessWidget {
  const ShareAppPage({super.key});

  final String shareText =
      'እባክዎ ይህ መተግበሪያ እንደ ቅድመ ሙከራ ነው። እባክዎ በቅርብ ቀን Play Store ይጠብቁን።';

  final List<Map<String, dynamic>> platforms = const [
    {
      'name': 'Telegram',
      'icon': FontAwesomeIcons.telegram,
      'color': Colors.blue,
      'appUrl': 'tg://msg?text=', // Telegram app
      'webUrl': 'https://t.me/share/url?url=&text=', // fallback web
    },
    {
      'name': 'Facebook',
      'icon': FontAwesomeIcons.facebook,
      'color': Colors.blueAccent,
      'appUrl': 'fb://facewebmodal/f?href=https://facebook.com/', // FB app
      'webUrl': 'https://www.facebook.com/sharer/sharer.php?u=', // fallback web
    },
    {
      'name': 'WhatsApp',
      'icon': FontAwesomeIcons.whatsapp,
      'color': Colors.green,
      'appUrl': 'whatsapp://send?text=', // WhatsApp app
      'webUrl': 'https://wa.me/?text=', // fallback web
    },
    {
      'name': 'Instagram',
      'icon': FontAwesomeIcons.instagram,
      'color': Colors.pinkAccent,
      'appUrl': null,
      'webUrl': null,
    },
    {
      'name': 'IMO',
      'icon': FontAwesomeIcons.commentDots,
      'color': Colors.lightBlue,
      'appUrl': null,
      'webUrl': null,
    },
    {
      'name': 'Chat',
      'icon': FontAwesomeIcons.comments,
      'color': Color.fromARGB(255, 32, 25, 71),
      'appUrl': null,
      'webUrl': null,
    },
  ];

  Future<void> _launchPlatform(
    Map<String, dynamic> platform,
    BuildContext context,
  ) async {
    final String text = Uri.encodeComponent(shareText);
    String? appUrl = platform['appUrl'];
    String? webUrl = platform['webUrl'];

    // Try app first
    if (appUrl != null) {
      final Uri uriApp = Uri.parse('$appUrl$text');
      if (await canLaunchUrl(uriApp)) {
        await launchUrl(uriApp, mode: LaunchMode.externalApplication);
        return;
      }
    }

    // Fallback to web
    if (webUrl != null) {
      final Uri uriWeb = Uri.parse('$webUrl$text');
      if (await canLaunchUrl(uriWeb)) {
        await launchUrl(uriWeb, mode: LaunchMode.externalApplication);
        return;
      }
    }

    // Neither available
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing not available for this platform.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'መተግበሪያን አጋራ',
          style: TextStyle(
            fontFamily: 'GeezMahtem',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView.builder(
        itemCount: platforms.length,
        itemBuilder: (context, index) {
          final platform = platforms[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: FaIcon(
                platform['icon'],
                color: platform['color'],
                size: 28,
              ),
              title: Text(
                platform['name'],
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () => _launchPlatform(platform, context),
            ),
          );
        },
      ),
    );
  }
}
