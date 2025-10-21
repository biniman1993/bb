import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class FloatingSearchWidget extends StatefulWidget {
  final Function(String) onQueryChanged;
  final List<String> suggestions;
  final Function(String selectedTitle) onSelect;

  const FloatingSearchWidget({
    super.key,
    required this.onQueryChanged,
    required this.suggestions,
    required this.onSelect,
  });

  @override
  State<FloatingSearchWidget> createState() => _FloatingSearchWidgetState();
}

class _FloatingSearchWidgetState extends State<FloatingSearchWidget> {
  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: controller,
      hint: 'መፈለጊያ ቃል ያስገቡ...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 300),
      onQueryChanged: widget.onQueryChanged,
      transition: CircularFloatingSearchBarTransition(),
      actions: [FloatingSearchBarAction.searchToClear(showIfClosed: false)],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.suggestions
                  .map(
                    (title) => ListTile(
                      title: Text(
                        title,
                        style: const TextStyle(fontFamily: 'GeezMahtem'),
                      ),
                      onTap: () {
                        controller.close();
                        widget.onSelect(title);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
