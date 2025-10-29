import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  int _selectedRating = 0;
  bool _submitted = false;

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
  }

  void _setRating(int rating) {
    setState(() {
      _selectedRating = rating;
    });
  }

  void _submitRating() {
    if (_selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating before submitting.'),
        ),
      );
      return;
    }

    setState(() {
      _submitted = true;
    });
  }

  // Open Play Store link
  Future<void> _openPlayStore() async {
    const String playStoreUrl =
        'https://play.google.com/store/apps/details?id=com.yourcompany.yourapp'; // Replace with your actual app ID

    final Uri url = Uri.parse(playStoreUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Play Store')),
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Rate Us',
          style: TextStyle(
            fontFamily: 'GeezMahtem',
            color: Colors.white,
            fontSize: 20,
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
        centerTitle: true, // ✅ Added for consistency
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: _submitted
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.thumb_up, size: 80, color: Colors.green),
                    const SizedBox(height: 20),
                    const Text(
                      'Thank you for your feedback!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'You rated us $_selectedRating star${_selectedRating > 1 ? 's' : ''}.',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: _openPlayStore,
                      icon: const Icon(Icons.feedback),
                      label: const Text(
                        'Send Feedback',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 32, 104),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'How would you rate this app?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      children: List.generate(5, (index) {
                        int starIndex = index + 1;
                        return IconButton(
                          iconSize: 40,
                          icon: Icon(
                            starIndex <= _selectedRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () => _setRating(starIndex),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _submitRating,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 32, 104),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
