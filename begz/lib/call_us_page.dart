import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class CallUsPage extends StatelessWidget {
  const CallUsPage({super.key});

  // Sample phone numbers
  final List<Map<String, String>> contacts = const [
    {'name': 'መስመር 1', 'phone': '+251911395884'},
    {'name': 'መስመር 2', 'phone': '+251913349609'},
    {'name': 'መስመር 3', 'phone': '+251968155172'},
    {'name': 'መስመር 4', 'phone': '+251913896273'},
  ];

  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $phoneNumber';
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "እኛን ለማገኘት",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'GeezMahtem',
            fontSize: 18,
            fontWeight: FontWeight.bold, // ✅ Added for consistency
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
        centerTitle: true, // ✅ Added for consistency
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Phone contacts
          ...contacts.map((contact) {
            return Card(
              color: const Color.fromARGB(255, 252, 252, 252),
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.phone,
                  color: Color.fromARGB(255, 25, 18, 88),
                ),
                title: Text(
                  contact['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(contact['phone']!),
                trailing: const Icon(
                  Icons.call,
                  color: Color.fromARGB(255, 16, 10, 53),
                ),
                onTap: () => _makePhoneCall(contact['phone']!),
              ),
            );
          }),
        ],
      ),
    );
  }
}
