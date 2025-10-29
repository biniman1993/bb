import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

  // Open Telegram app if installed, else open in browser
  Future<void> _openTelegram() async {
    final Uri tgUrl = Uri.parse("tg://resolve?domain=ReformationLife_Join");
    final Uri webUrl = Uri.parse("https://t.me/ReformationLife_Join");

    if (await canLaunchUrl(tgUrl)) {
      await launchUrl(tgUrl, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }

  void _openFacebook(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Coming soon!"),
        duration: Duration(seconds: 2),
      ),
    );
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
        title: const Text(
          'ማህበራዊ መገናኛ',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'GeezMahtem',
            fontSize: 18,
            fontWeight: FontWeight.bold, // ✅ Added for consistency
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'ለአዳዲስ መተግበሪያዎች እና የተለያዩ ትምህርቶችን ለማግኘት ማህበራዊ መገናኛዎቻችንን ይከታተሉ።',
                  style: TextStyle(fontSize: 16, fontFamily: 'GeezMahtem'),
                ),
              ),
              // Telegram Card
              Card(
                color: const Color.fromARGB(255, 252, 252, 252),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.telegram, color: Colors.blue),
                  title: const Text(
                    "Join Our Telegram Channel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("ተሐድሶ ሕይወት ዓለም ቤተክርስቲያን"),
                  trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
                  onTap: _openTelegram,
                ),
              ),
              // Facebook Card
              Card(
                color: const Color.fromARGB(255, 252, 252, 252),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.facebook, color: Colors.blue),
                  title: const Text(
                    "Follow Us on Facebook",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("ተሐድሶ ሕይወት ዓለም ቤተክርስቲያን"),
                  trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
                  onTap: () => _openFacebook(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
