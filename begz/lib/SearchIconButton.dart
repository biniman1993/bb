import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page of html/PageView.dart';

class SearchIconButton extends StatelessWidget {
  final List<String> titles;

  const SearchIconButton({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search, color: Colors.white),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SimpleSearchScreen(titles: titles)),
      ),
    );
  }
}

class SimpleSearchScreen extends StatefulWidget {
  final List<String> titles;

  const SimpleSearchScreen({super.key, required this.titles});

  @override
  State<SimpleSearchScreen> createState() => _SimpleSearchScreenState();
}

class _SimpleSearchScreenState extends State<SimpleSearchScreen> {
  List<String> _filteredTitles = [];

  @override
  void initState() {
    super.initState();
    _filteredTitles = widget.titles;
  }

  void _onQueryChanged(String query) {
    setState(() {
      _filteredTitles = query.trim().isEmpty
          ? widget.titles
          : widget.titles.where((title) => title.contains(query)).toList();
    });
  }

  void _onSelect(String title) {
    final index = widget.titles.indexOf(title);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HtmlPageView(startIndex: index, titles: widget.titles),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // change this to your desired back arrow color
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 9.0),
          child: const Text(
            'መፈለጊያ ቃል',
            style: TextStyle(
              fontFamily: 'GeezMahtem',
              color: Color.fromARGB(255, 253, 252, 252),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 31, 38, 87), // start color
                Color.fromARGB(255, 131, 131, 168), // end color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '  መፈለጊያ ቃል ያስገቡ...',
                hintStyle: TextStyle(
                  fontFamily: 'GeezMahtem',
                  color: Color.fromARGB(255, 102, 102, 102),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 6),
                  child: const Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onChanged: _onQueryChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTitles.length,
              itemBuilder: (context, index) {
                final title = _filteredTitles[index];
                return ListTile(
                  title: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'GeezMahtem',
                      fontSize: 17,
                    ),
                  ),
                  onTap: () => _onSelect(title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
