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
  late PageController pageController;
  late AnimationController _arrowController;
  late Animation<Offset> _arrowAnimation;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1, viewportFraction: 0.6);

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
    pageController.dispose();
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
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null &&
            details.primaryVelocity! < -100) {
          _navigateToNextScreen();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 26,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 227, 230, 240),
                  Color.fromARGB(255, 194, 199, 198),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sdsfdf.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 0),
                      Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.0),
                            child: Text(
                              'በእግዚአብሔር ቃል',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'GeezMahtem',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            'እውነት መኖር!!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'GeezMahtem',
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 290,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return _buildPageItem(index);
                          },
                        ),
                      ),
                      const SizedBox(height: 4),
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
                                        fontSize: 16,
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
                                          Color.fromARGB(255, 177, 212, 212),
                                          Color.fromARGB(255, 131, 128, 125),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'እንቀጥል',
                                            style: TextStyle(
                                              fontFamily: 'GeezMahtem',
                                              fontSize: 25,
                                              color: Color.fromARGB(
                                                  255, 37, 37, 37),
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
                                                    255, 31, 30, 30),
                                                size: 30,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageItem(int index) {
    List<String> assetPaths = [
      'assets/e.jpg',
      'assets/splash.jpg',
      'assets/c7.jpg',
    ];

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double scale = 1.0;
        double opacity = 1.0;
        double translateX = 0.0;

        if (pageController.hasClients &&
            pageController.position.haveDimensions) {
          double difference = pageController.page! - index;
          scale = (1 - (difference.abs() * 0.2)).clamp(0.85, 1.0);
          opacity = (1 - (difference.abs() * 0.4)).clamp(0.6, 1.0);
          translateX = difference * 0;
        }

        return Transform.translate(
          offset: Offset(translateX, 0),
          child: Transform.scale(
            scale: Curves.easeOut.transform(scale),
            child: Opacity(opacity: opacity, child: child),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(66, 104, 103, 103),
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(assetPaths[index], fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
