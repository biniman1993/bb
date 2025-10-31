import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tehadso/listoftitile/listoftimhirt.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> with SingleTickerProviderStateMixin {
  late AnimationController _arrowController;
  late Animation<Offset> _arrowAnimation;
  @override
  void initState() {
    super.initState();

    // Add this line for edge-to-edge full screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Set status bar style in initState
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    // Arrow animation setup
    _arrowController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);

    _arrowAnimation = Tween<Offset>(
            begin: const Offset(0, 0), end: const Offset(0.2, 0))
        .animate(
            CurvedAnimation(parent: _arrowController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true); // ✅ save flag

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ScrollableListView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null &&
            details.primaryVelocity! < -100) {
          _navigateToNextScreen();
        }
      },
      child: Scaffold(
        // Remove AppBar completely to allow image to go to very top
        appBar: null,

        body: Stack(
          children: [
            // Remove SafeArea to allow content to go under status bar
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image at very top (covering status bar area)
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height *
                        0.4, // Increased height
                    decoration: const BoxDecoration(),
                    child: Stack(
                      children: [
                        // Main image
                        Image.asset(
                          'assets/sle.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        // Gradient overlay to make status bar content readable
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.1],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Text below the image
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                        child: Text(
                          'በእግዚአብሔር ቃል',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GeezMahtem',
                            color: Color.fromARGB(255, 49, 48, 48),
                          ),
                        ),
                      ),
                      Text(
                        'እውነት መኖር!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GeezMahtem',
                          color: Color.fromARGB(255, 8, 168, 168),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Description and button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    color: Colors.black.withOpacity(0.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 1),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(child: SizedBox(width: 20)),
                                TextSpan(
                                  text:
                                      'ይህ በእግዚአብሔር ቃል እውነት መኖር የሚል ትምህርት በመንፈስ ቅዱስ ምሪት '
                                      'በመታገዝ በተሐድሶ ህይወት አለም አቀፍ ቤተ-ክርስቲያን ተጽፎ የተዘጋጀ ትምህርት ነው፡፡ '
                                      'ቤተ-ክርስቲያን በምድር ዘመኗ መመራትና መኖር የሚገባት መጽሐፍ  ቅዱስ '
                                      'በሚሰጣት ሰማያዊ ስርዓትና ህግ መሰረት ነው፤ እንጂ በምድራዊ ስርዓት አይደለም። '
                                      'በመሆኑም ትምህርቱም በዋናነት በዚህ ዘመን ያለችሁ ቤተ-ክርስቲያን የለቀቀቻቸውን መጽሐፍ ቅዱሳዊ እውነቶች እያሳየን፤ እነዚህን እውነቶች በመልቀቋም ያጣችውን በረከቶች ይነግረናል:: ትምህርቱም መጽሀፍ ቅዱሳችንን መሰረት አድርጎ ከተሐድሶ አላማ አንጻር የተዘጋጀ ነው፡፡',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'GeezMahtem',
                                    color: Colors.black,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 19),
                        GestureDetector(
                          onTap: _navigateToNextScreen,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 9, 175, 175),
                                      Color.fromARGB(255, 27, 27, 26),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 3,
                                      blurRadius: 6,
                                      offset: const Offset(3, 4),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'እንቀጥል',
                                        style: TextStyle(
                                          fontFamily: 'GeezMahtem',
                                          fontSize: 23,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      SlideTransition(
                                        position: _arrowAnimation,
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: FaIcon(
                                            FontAwesomeIcons.arrowRight,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
