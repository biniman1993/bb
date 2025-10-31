import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tehadso/listoftimhirt.dart';

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

  void _navigateToNextScreen() {
    Navigator.push(
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: Image.asset(
                  'assets/sle.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              pinned: false,
              floating: false,
              snap: false,
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 227, 230, 240),
                      Color.fromARGB(255, 194, 199, 198),
                    ],
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'በእግዚአብሔር ቃል',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GeezMahtem',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'እውነት መኖር!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GeezMahtem',
                          color: Color.fromARGB(255, 15, 153, 146),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'ይህ በእግዚአብሔር ቃል እውነት መኖር የሚል ትምህርት በመንፈስ ቅዱስ ምሪት '
                        'በመታገዝ በተሐድሶ ህይወት አለም አቀፍ ቤተ-ክርስቲያን ተጽፎ የተዘጋጀ ትምህርት ነው፡፡ '
                        'ቤተ-ክርስቲያን በምድር ዘመኗ መመራትና መኖር የሚገባት መጽሐፍ  ቅዱስ '
                        'በሚሰጣት ሰማያዊ ስርዓትና ህግ መሰረት ነው፤ እንጂ በምድራዊ ስርዓት አይደለም። '
                        'በመሆኑም ትምህርቱም በዋናነት በዚህ ዘመን ያለችሁ ቤተ-ክርስቲያን የለቀቀቻቸውን መጽሐፍ ቅዱሳዊ እውነቶች እያሳየን፤ እነዚህን እውነቶች በመልቀቋም ያጣችውን በረከቶች ይነግረናል:: ትምህርቱም መጽሀፍ ቅዱሳችንን መሰረት አድርጎ ከተሐድሶ አላማ አንጻር የተዘጋጀ ነው፡፡',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'GeezMahtem',
                          color: Colors.black,
                          height: 1.6,
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
                                  vertical: 12, horizontal: 20),
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
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'እንቀጥል',
                                    style: TextStyle(
                                      fontFamily: 'GeezMahtem',
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 37, 37, 37),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SlideTransition(
                                    position: _arrowAnimation,
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: FaIcon(
                                        FontAwesomeIcons.arrowRight,
                                        color: Color.fromARGB(255, 31, 30, 30),
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
                      const SizedBox(height: 20),
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
}
