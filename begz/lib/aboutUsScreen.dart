import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  // 📞 Phone Launcher
  void _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  // 📧 Email Launcher
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  // 🌍 Location (Google Maps)
  void _launchLocation(String query) async {
    final Uri mapUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}',
    );
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $mapUri");
    }
  }

  Widget _buildChurchCard({
    required String name,
    required String phone,
    required String location,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 6,
      shadowColor: Colors.deepPurple.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 39, 15, 94),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.green.shade700),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _launchPhone(phone),
                  child: Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 13, 187, 164),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red.shade600),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _launchLocation(location),
                  child: Text(
                    location,
                    style: const TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 233, 114, 3),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            toolbarHeight: 70,
            centerTitle: true,
            pinned: true,
            backgroundColor: Color.fromARGB(255, 6, 77, 67),
            expandedHeight: 280,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: const Text(
                  "ስለ ትምህርቱ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black, blurRadius: 6)],
                  ),
                ),
              ),
              centerTitle: true,
              background: Hero(
                tag: "headerImage",
                child: Image.asset(
                  "assets/sle.jpg",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // ✨ Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // 🔹 Title
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "በእግዚአብሔር ቃል እውነት መኖር",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'GeezMahtem',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 9, 131, 115),
                    ),
                  ),
                ),

                // 🔹 Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "ይህ “በእግዚአብሔር ቃል እውነት መኖር” በመንፈስ ቅዱስ ምሪት በመታገዝ በተሐድሶ ህይወት አለም አቀፍ ቤተ-ክርስቲያን ተጽፎ የተዘጋጀ ትምህርት ነው፡፡ትምህርቱም መጽሀፍ ቅዱሳችንን መሰረት አድርጎ ከተሐድሶ አላማ አንጻር የተዘጋጀ ሲሆን፤ የዚህ ዘመን ቤተ-ክርስቲያን የለቀቀቻቸውን መጽሀፍ ቅዱሳዊ እውነቶች እያሳየን፤ እነዚህን እውነቶች በመልቀቋም ያጣችውን በረከቶች ይነግረናል :: አያይዞም ቤተ-ክርስቲያን በምን መንገድ ብትሄድ እንደሚበጃት ያስተምረናል::",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'GeezMahtem',
                      color: Colors.grey.shade800,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "የቤ/ክቱ ፓ/ር መልእክት፡",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'GeezMahtem',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 9, 131, 115),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "ይህ ትምህርት የሚያተኩረው የዘመኑ ቤተ-ክርስቲያን ከለቀቀቻቸው ከስምንቱ ዋና ዋና ነጥቦች (የዘመኑ ቤተክርስቲያን ስርዓቷና መልኳ በሚለው እርዕስ ውስጥ ተዘርዝረዋል) መካከል መጽሀፍ ቅዱስ ለወንዶችና ለሴቶች በሰጠው ሰማያዊ ስርዐት ዙሪያ እንዴት ሰይጣን ቤተ-ክርስቲያንን እንዳሳታት በዝርዝር ከሚያስተምረው ትምህርት የተወሰደ ነው::በመሆኑም ቤተ-ክርስቲያን በምድር ዘመኗ መመራትና መኖር የሚገባት መፅሐፍ ቅዱስ በሚሰጣት ሰማያዊ ስርአትና ህግ መሰረት ነው እንጂ በምድራዊ ስርዐት አይደለም፡፡እኛም ይህንን እውነት አምነን ለመከተል ቆርጠን ተነስተናል፤ እግዚአብሔርም ይረዳናል:: ‹‹የሰማይ አምላክ ያከናውንልናል እኛም ባሪያዎቹ ተነስተን እንሰራለን:: ነህ2፤20 ›› በዚህም ትምህርት ዙሪያ ማንኛውም አይነት ጥያቄ ወይንም አስተያየት ቢኖራችሁ በዚህ አድራሻ ማግኘት ይችላሉ፡፡",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'GeezMahtem',
                      color: Colors.grey.shade800,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ),
                // 🔹 Pastor Info
                Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  elevation: 8,
                  shadowColor: Colors.deepPurple.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          "ፓ/ር አበበ ደጀኔ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 9, 131, 115),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GeezMahtem',
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => _launchPhone("0911395884"),
                          child: const Text(
                            "ስልክ፡ 0911395884",
                            style: TextStyle(
                              fontFamily: 'GeezMahtem',
                              fontSize: 16,
                              color: Color.fromARGB(255, 7, 122, 107),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _launchEmail("abebedejene12@gmail.com"),
                          child: const Text(
                            "ኢሜል፡ abebedejene12@gmail.com",
                            style: TextStyle(
                              fontFamily: 'GeezMahtem',
                              fontSize: 16,
                              color: Color.fromARGB(255, 6, 110, 96),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Bible Blessing
                const SizedBox(height: 20),

                // 🔹 Churches List
                const Text(
                  "⛪ የቤተክርስቲያናት ዝርዝር",
                  style: TextStyle(
                    fontFamily: 'GeezMahtem',
                    fontSize: 20,
                    color: Color.fromARGB(255, 9, 131, 115),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                _buildChurchCard(
                  name: "አዲስ አበባ",
                  phone: "0911395884",
                  location: "Addis Ababa, Ethiopia",
                ),
                _buildChurchCard(
                  name: "ሆሳዕና",
                  phone: "0913349609",
                  location: "Hossana, Ethiopia",
                ),
                _buildChurchCard(
                  name: "ደብረ ዘይት",
                  phone: "0968155172",
                  location: "Debre Zeit, Ethiopia",
                ),
                _buildChurchCard(
                  name: "ዱከም",
                  phone: "0913896273",
                  location: "Dukem, Ethiopia",
                ),
                _buildChurchCard(
                  name: "ቡሻና",
                  phone: "0926119792",
                  location: "Bushana, Ethiopia",
                ),
                _buildChurchCard(
                  name: "ጋቦ",
                  phone: "0912787929",
                  location: "hossana, Ethiopia",
                ),

                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "“የጌታ የኢየሱስ ክርስቶስ ጸጋ፤ "
                    "የእግዚአብሔርም ፍቅር፤ "
                    "የመንፈስ ቅዱስም ኅብረት "
                    "ከሁላችንም ጋር ይሁን። አሜን!!”",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GeezMahtem',
                      color: Color.fromARGB(255, 9, 131, 115),
                    ),
                  ),
                ),

                // 🔹 Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    backgroundColor: Color.fromARGB(255, 9, 131, 115),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
