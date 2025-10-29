import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({super.key});

  // Force open in browser instead of apps
  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // ✅ Always open in browser
      );
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // white icons
          statusBarBrightness: Brightness.dark,
          // iOS fix
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        title: const Text(
          "About Developer",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF142068), Color(0xFF8383A8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              shadowColor: Colors.blueAccent.withOpacity(0.4),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/bini.jpg"),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Biniyam Abera",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Flutter & Front-end Developer",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "“Turning ideas into scalable apps & digital solutions.”",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // About Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              shadowColor: Colors.purpleAccent.withOpacity(0.3),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB3FFAB), Color(0xFF12FFF7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "This app is developed by Biniyam Abera for Tehadiso International Church (2025). "
                  "It is built with Flutter to provide a seamless and engaging experience. "
                  "Passionate about crafting impactful software that makes life easier and more connected.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Contact Section with Chips
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              shadowColor: Colors.orangeAccent.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact me!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ActionChip(
                          label: const Text("Telegram"),
                          backgroundColor: const Color(0xFF0088CC),
                          labelStyle: const TextStyle(color: Colors.white),
                          onPressed: () => _launchUrl("https://t.me/binniy"),
                        ),
                        ActionChip(
                          label: const Text("GitHub"),
                          backgroundColor: const Color(0xFF333333),
                          labelStyle: const TextStyle(color: Colors.white),
                          onPressed: () =>
                              _launchUrl("https://github.com/biniman1993"),
                        ),
                        ActionChip(
                          label: const Text("LinkedIn"),
                          backgroundColor: const Color(0xFF0A66C2),
                          labelStyle: const TextStyle(color: Colors.white),
                          onPressed: () => _launchUrl(
                            "https://www.linkedin.com/in/biniyam-abera-177874277?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app",
                          ),
                        ),
                        ActionChip(
                          label: const Text("Email"),
                          backgroundColor: const Color(0xFFE53935),
                          labelStyle: const TextStyle(color: Colors.white),
                          onPressed: () =>
                              _launchUrl("mailto:biniyamaberagirma@gmail.com"),
                        ),
                        ActionChip(
                          label: const Text("Phone"),
                          backgroundColor: const Color(0xFF43A047),
                          labelStyle: const TextStyle(color: Colors.white),
                          onPressed: () => _launchUrl("tel:+251902914538"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Contact Section ListTiles
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              shadowColor: Colors.greenAccent.withOpacity(0.3),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.blue),
                    title: const Text(
                      "biniyamaberagirma@gmail.com",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () =>
                        _launchUrl("mailto:biniyamaberagirma@gmail.com"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.green),
                    title: const Text(
                      "+251 902914538",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => _launchUrl("tel:+251902914538"),
                  ),
                  const ListTile(
                    leading: Icon(Icons.location_on, color: Colors.deepOrange),
                    title: Text(
                      "Addis Ababa, Ethiopia",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Social Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.linked_camera, color: Colors.blue),
                  onPressed: () =>
                      _launchUrl("https://www.linkedin.com/in/biniyam-abera"),
                  tooltip: "LinkedIn",
                ),
                IconButton(
                  icon: const Icon(Icons.code, color: Colors.black),
                  onPressed: () => _launchUrl("https://github.com/biniman1993"),
                  tooltip: "GitHub",
                ),
                IconButton(
                  icon: const Icon(Icons.web, color: Colors.purple),
                  onPressed: () => _launchUrl("https://t.me/binniy"),
                  tooltip: "Telegram",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
