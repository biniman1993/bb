import 'dart:convert';
import 'package:tehadso/appbar/appbar.dart';
import 'package:tehadso/listoftitile/listoftimhirt.dart';
import 'package:tehadso/page%20of%20html/flotscreen.dart';
import 'package:tehadso/settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show
        rootBundle,
        SystemUiOverlayStyle,
        SystemChrome,
        SystemUiMode,
        SystemUiOverlay;
import 'package:flutter_html/flutter_html.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HtmlPageView extends StatefulWidget {
  final int startIndex;
  final List<String> titles;

  const HtmlPageView({
    super.key,
    required this.startIndex,
    required this.titles,
  });

  @override
  State<HtmlPageView> createState() => _HtmlPageViewState();
}

class _HtmlPageViewState extends State<HtmlPageView>
    with WidgetsBindingObserver {
  late final PageController _controller;
  final PanelController _panelController = PanelController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  late List<bool> pageFavourites;
  late List<String?> pageNotes;

  List<String> htmlContents = [];
  Map<String, String> verseTexts = {};

  double fontSize = 17.0;
  double _baseFontSize = 17.0;
  final ValueNotifier<double> fontNotifier = ValueNotifier<double>(17.0); // NEW

  String fontType = 'GeezMahtem';
  Color backgroundColor = Colors.white;
  bool nightMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // ✅ Add lifecycle observer

    pageFavourites = List.generate(widget.titles.length, (_) => false);
    pageNotes = List.generate(widget.titles.length, (_) => null);

    _initializePageController();
    _setFullScreenMode(); // ✅ Set full-screen mode

    loadAllHtmlPages();
    loadVerseTexts();

    loadFavouritesAndNotes().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // ✅ Remove lifecycle observer
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  void _setFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // ✅ Keep this as DARK
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _setFullScreenMode(); // ✅ Restore full-screen mode when app resumes
    }
  }

  void _initializePageController() {
    _controller = PageController(initialPage: widget.startIndex);
    _currentPage.value = widget.startIndex;

    _controller.addListener(() {
      final page = _controller.page?.round() ?? widget.startIndex;
      if (page != _currentPage.value) {
        _currentPage.value = page;
        // Remove saving to SharedPreferences
      }
    });

    setState(() {});
  }

  Future<void> loadFavouritesAndNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final favList = prefs.getStringList('favourites');
    if (favList != null && favList.length == widget.titles.length) {
      setState(() {
        pageFavourites = favList.map((e) => e == '1').toList();
      });
    }

    final noteList = prefs.getStringList('notes');
    if (noteList != null && noteList.length == widget.titles.length) {
      setState(() {
        pageNotes = noteList.map((e) => e.isEmpty ? null : e).toList();
      });
    }
  }

  Future<void> saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'favourites',
      pageFavourites.map((e) => e ? '1' : '0').toList(),
    );
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notes', pageNotes.map((e) => e ?? '').toList());
  }

  Future<void> loadAllHtmlPages() async {
    List<String> contents = [];
    for (int i = 1; i <= widget.titles.length; i++) {
      final filePath = 'assets/html/page_$i.html';
      try {
        final content = await rootBundle.loadString(filePath);
        contents.add(content);
      } catch (_) {
        contents.add('<p>Page $i not found.</p>');
      }
    }
    setState(() => htmlContents = contents);
  }

  Future<void> loadVerseTexts() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/verses.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      setState(() {
        verseTexts = jsonMap.map(
          (key, value) => MapEntry(key, value.toString()),
        );
      });
    } catch (_) {
      setState(() => verseTexts = {});
    }
  }

  void openSettingsPanel() => _panelController.open();
  void closeSettingsPanel() => _panelController.close();

  void showVersePopup(String verse) {
    final text = verseTexts[verse] ?? 'Verse text not found';
    double verseFontSize = 14;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "VerseDialog",
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(animation.value),
          child: Opacity(
            opacity: animation.value,
            child: StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.white,
                  contentPadding: const EdgeInsets.all(20),
                  content: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.menu_book,
                            size: 50,
                            color: Color.fromARGB(221, 70, 71, 128),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$verse',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: 'GeezMahtem',
                              color: Color.fromARGB(221, 59, 60, 134),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontSize: verseFontSize,
                                  fontFamily: 'GeezMahtem',
                                  color: const Color.fromARGB(255, 22, 22, 22),
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(221, 70, 71, 128),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    verseFontSize += 2;
                                  });
                                },
                                child: const Text(
                                  "+",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(221, 70, 71, 128),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "Close",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Color getDynamicFontColor() {
    if (!nightMode) return Colors.black;
    if (backgroundColor == Colors.black) return Colors.white;
    return const Color.fromARGB(255, 243, 168, 106);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // ✅ Allow content to extend behind AppBar
      drawer: Mybar(),
      appBar: AppBar(
        //
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // ✅ Keep this as LIGHT
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 214, 214, 235),
                Color.fromARGB(255, 33, 38, 95),
              ],
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: .0, right: 29),
          child: ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (_, page, __) {
              return Text(
                widget.titles[page],
                style: const TextStyle(
                  fontFamily: 'jiretnn',
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  color: Color.fromARGB(255, 252, 252, 252),
                ),
              );
            },
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (_, page, __) {
                return IconButton(
                  icon: Icon(
                    pageFavourites[page] ? Icons.star : Icons.star_border,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      pageFavourites[page] = !pageFavourites[page];
                      saveFavourites();
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: IconButton(
              icon: const Icon(Icons.text_fields),
              color: Colors.white,
              onPressed: openSettingsPanel,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: IconButton(
              icon: const Icon(Icons.translate),
              color: Colors.white,
              onPressed: () => showTranslationDialog(context),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (_panelController.isPanelOpen) closeSettingsPanel();
          },
          onScaleStart: (details) {
            _baseFontSize = fontSize;
          },
          onScaleUpdate: (details) {
            setState(() {
              fontSize = (_baseFontSize * details.scale).clamp(12.0, 50.0);
              fontNotifier.value = fontSize; // 🔹 notify SettingsBottomPanel
            });
          },
          onScaleEnd: (details) async {
            _baseFontSize = fontSize;
            final prefs = await SharedPreferences.getInstance();
            prefs.setDouble(
                'fontSize', fontSize); // 🔹 persist pinch zoom changes
          },
          child: SlidingUpPanel(
            controller: _panelController,
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height * 0.4,
            backdropEnabled: true,
            backdropTapClosesPanel: true,
            panel: SettingsBottomPanel(
              fontNotifier: fontNotifier, // 🔹 NEW
              onFontSizeChanged: (value) {
                setState(() => fontSize = value);
                fontNotifier.value = value; // 🔹 sync with ValueNotifier
              },
              onFontTypeChanged: (value) => setState(() => fontType = value),
              onBackgroundColorChanged: (value) =>
                  setState(() => backgroundColor = value),
              onNightModeChanged: (value) => setState(() => nightMode = value),
              onClosePanel: closeSettingsPanel,
            ),
            body: Container(
              color: backgroundColor,
              child: htmlContents.isEmpty
                  ? const SizedBox.shrink()
                  : PageView.builder(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.titles.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          key: ValueKey(
                              fontSize), // 🔹 Forces rebuild when font size changes
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: fontSize * 0.5,
                          ), // Dynamic padding based on font size
                          physics: const BouncingScrollPhysics(),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectionArea(
                                      child: Html(
                                        data: htmlContents[index],
                                        onLinkTap: (url, context, attributes) {
                                          if (url != null &&
                                              url.startsWith('verse:')) {
                                            final verse =
                                                url.replaceFirst('verse:', '');
                                            showVersePopup(verse);
                                          }
                                        },
                                        style: {
                                          "a": Style(
                                            color: const Color.fromARGB(
                                                255, 55, 115, 184),
                                            textDecoration: TextDecoration.none,
                                            fontFamily: fontType,
                                          ),
                                          "body": Style(
                                            fontSize: FontSize(fontSize),
                                            fontFamily: fontType,
                                            fontWeight: FontWeight.w500,
                                            color: nightMode
                                                ? Colors.white
                                                : Colors.black,
                                            backgroundColor: backgroundColor,
                                            lineHeight: LineHeight.number(1.5),
                                            margin: Margins.all(1),
                                            padding: HtmlPaddings.zero,
                                          ),
                                          "p": Style(
                                            fontSize: FontSize(fontSize),
                                            fontFamily: fontType,
                                            textAlign: TextAlign.justify,
                                            color: nightMode
                                                ? Colors.white
                                                : Colors.black,
                                            margin: Margins.only(
                                                top: 0, bottom: 12),
                                            padding: HtmlPaddings.zero,
                                          ),
                                          "h2": Style(
                                            fontSize: FontSize(fontSize + 5),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: fontType,
                                            color: const Color.fromARGB(
                                                255, 55, 115, 184),
                                            margin: Margins.only(
                                                top: 10, bottom: 0),
                                            padding: HtmlPaddings.zero,
                                          ),
                                          "h3": Style(
                                            fontSize: FontSize(fontSize + 4),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: fontType,
                                            color: const Color.fromARGB(
                                                255, 55, 115, 184),
                                            margin: Margins.only(
                                                top: 12, bottom: 8),
                                            padding: HtmlPaddings.zero,
                                          ),
                                          "ul": Style(
                                            fontSize: FontSize(fontSize),
                                            fontFamily: fontType,
                                            listStyleType:
                                                ListStyleType.disclosureClosed,
                                            margin: Margins.only(
                                                top: 4, bottom: 12, left: 45),
                                            padding: HtmlPaddings.zero,
                                          ),
                                          "ol": Style(
                                            fontSize: FontSize(fontSize),
                                            fontFamily: fontType,
                                            margin: Margins.only(
                                                top: 3, bottom: 12, left: 45),
                                            padding: HtmlPaddings.zero,
                                          ),
                                          "li": Style(
                                            fontSize: FontSize(fontSize - 1),
                                            fontFamily: fontType,
                                            margin: Margins.only(bottom: 6),
                                            padding: HtmlPaddings.zero,
                                          ),
                                          "strong": Style(
                                            fontWeight: FontWeight.bold,
                                            color: getDynamicFontColor(),
                                          ),
                                          "em": Style(
                                            fontStyle: FontStyle.italic,
                                            color: nightMode
                                                ? (backgroundColor ==
                                                        Colors.black
                                                    ? Colors.white70
                                                    : const Color.fromARGB(
                                                        255, 255, 230, 180))
                                                : Colors.black87,
                                          ),
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            160), // 🔹 Ensures bottom text is always visible
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
      floatingActionButton: ValueListenableBuilder<int>(
        valueListenable: _currentPage,
        builder: (_, page, __) {
          return PageActionOverlay(
            note: pageNotes[page],
            isFavourite: pageFavourites[page],
            onNoteSaved: (_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Note Saved!")));
              print("Note button clicked on page $page, not implemented yet.");
            },
            onFavouriteToggled: (isFav) {
              setState(() => pageFavourites[page] = isFav);
              saveFavourites();
              print("Favourite toggled on page $page: $isFav");
            },
            onMark: () {
              print("Mark clicked on page $page");
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(221, 70, 71, 128),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'GeezMahtem',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'GeezMahtem',
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ScrollableListView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  final tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: Curves.easeInOut));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 600),
              ),
            );
          } else if (index == 1) {
            openSettingsPanel();
          } else if (index == 2) {
            if (_controller.hasClients && _currentPage.value - 1 >= 0) {
              _controller.animateToPage(
                _currentPage.value - 1,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
              );
            }
          } else if (index == 3) {
            if (_controller.hasClients &&
                _currentPage.value + 1 < widget.titles.length) {
              _controller.animateToPage(
                _currentPage.value + 1,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
              );
            }
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'መነሻ'),
          BottomNavigationBarItem(icon: Icon(Icons.tune), label: 'ማስተካከያ'),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'ተመለስ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward),
            label: 'ቀጣይ',
          ),
        ],
      ),
    );
  }
}

void showTranslationDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "TranslationDialog",
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        scale: Curves.easeOutBack.transform(animation.value),
        child: Opacity(
          opacity: animation.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: const Color.fromARGB(255, 238, 236, 236),
            contentPadding: const EdgeInsets.all(20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.translate,
                  size: 50,
                  color: Color.fromARGB(255, 73, 79, 114),
                ),
                const SizedBox(height: 12),
                const Text(
                  '⚠️ Translation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'For now it is not available. Coming soon!',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 73, 79, 114),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
