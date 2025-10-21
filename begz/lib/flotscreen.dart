import 'package:flutter/material.dart';

class PageActionOverlay extends StatefulWidget {
  final String? note;
  final bool isFavourite;
  final Function(String? note) onNoteSaved;
  final Function(bool isFav) onFavouriteToggled;
  final Function()? onMark;

  const PageActionOverlay({
    super.key,
    this.note,
    this.isFavourite = false,
    required this.onNoteSaved,
    required this.onFavouriteToggled,
    this.onMark,
  });

  @override
  State<PageActionOverlay> createState() => _PageActionOverlayState();
}

class _PageActionOverlayState extends State<PageActionOverlay> {
  late bool fabExpanded;
  late String? noteText;
  late bool isFav;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    fabExpanded = false;
    noteText = widget.note;
    isFav = widget.isFavourite;
    noteController = TextEditingController(text: noteText);
  }

  void _toggleFavourite() {
    setState(() {
      isFav = !isFav;
      fabExpanded = false;
    });
    widget.onFavouriteToggled(isFav);
  }

  void _showNoteDialog() {
    noteController.text = noteText ?? '';
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "NoteDialog",
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
              backgroundColor: const Color.fromARGB(255, 245, 243, 243),
              contentPadding: const EdgeInsets.all(20),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.note_alt_outlined,
                    size: 50,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'ማስታወሻ',
                    style: TextStyle(
                      fontFamily: 'GeezMahtem',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: noteController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'ማስታወሻዎትን እዚህ ያስገቡ...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          noteController.clear();
                          setState(() => noteText = null);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "ሰርዝ",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontFamily: 'GeezMahtem',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () {
                            setState(() => noteText = noteController.text);
                            widget.onNoteSaved(noteText);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "አስቀምጥ",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggleFab() => setState(() => fabExpanded = !fabExpanded);
  void _closeFab() => setState(() => fabExpanded = false);

  @override
  void didUpdateWidget(covariant PageActionOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    isFav = widget.isFavourite;
    noteText = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Tap outside to close FAB
        if (fabExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeFab,
              child: Container(color: Colors.transparent),
            ),
          ),

        // Floating action buttons
        Positioned(
          bottom: 15,
          right: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (fabExpanded) ...[
                FloatingActionButton(
                  heroTag: 'mark_fab',
                  mini: true,
                  onPressed: () {
                    widget.onMark?.call();
                    _closeFab();
                  },
                  backgroundColor: const Color.fromARGB(255, 76, 51, 112),
                  child: const Icon(
                    Icons.format_color_fill,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'note_fab',
                  mini: true,
                  onPressed: () {
                    _showNoteDialog();
                    _closeFab();
                  },
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.note_add),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'fav_fab',
                  mini: true,
                  onPressed: _toggleFavourite,
                  backgroundColor: Colors.red,
                  child: Icon(
                    isFav ? Icons.star : Icons.star_border,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              FloatingActionButton(
                heroTag: 'main_fab',
                onPressed: _toggleFab,
                backgroundColor: const Color.fromARGB(255, 138, 132, 173),
                shape: const CircleBorder(),
                child: Icon(
                  fabExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
