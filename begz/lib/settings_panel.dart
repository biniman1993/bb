import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBottomPanel extends StatefulWidget {
  final Function(double) onFontSizeChanged;
  final Function(String) onFontTypeChanged;
  final Function(Color) onBackgroundColorChanged;
  final Function(bool) onNightModeChanged;
  final VoidCallback onClosePanel;

  const SettingsBottomPanel({
    super.key,
    required this.onFontSizeChanged,
    required this.onFontTypeChanged,
    required this.onBackgroundColorChanged,
    required this.onNightModeChanged,
    required this.onClosePanel,
  });

  @override
  State<SettingsBottomPanel> createState() => _SettingsBottomPanelState();
}

class _SettingsBottomPanelState extends State<SettingsBottomPanel> {
  double fontSize = 16;
  String fontType = 'GeezMahtem';
  Color bgColor = Colors.white;
  bool isNightMode = false;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  // Load saved settings from SharedPreferences
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fontSize = prefs.getDouble('fontSize') ?? 16;
      fontType = prefs.getString('fontType') ?? 'GeezMahtem';
      bgColor = Color(prefs.getInt('bgColor') ?? Colors.white.value);
      isNightMode = prefs.getBool('isNightMode') ?? false;
    });

    // Apply loaded settings to parent
    widget.onFontSizeChanged(fontSize);
    widget.onFontTypeChanged(fontType);
    widget.onBackgroundColorChanged(bgColor);
    widget.onNightModeChanged(isNightMode);
  }

  // Function to get dynamic font color based on selected background
  Color getDynamicFontColor() {
    if (!isNightMode && bgColor == Colors.white) return Colors.black; // Light
    if (isNightMode && bgColor == Colors.black) return Colors.white; // Dark
    if (bgColor == const Color.fromARGB(255, 67, 110, 116)) {
      return const Color.fromARGB(255, 255, 214, 170); // Deep
    }
    return Colors.black;
  }

  // Update background color and night mode and save
  void updateBackground(Color color, bool night) async {
    setState(() {
      bgColor = color;
      isNightMode = night;
    });
    widget.onBackgroundColorChanged(bgColor);
    widget.onNightModeChanged(isNightMode);

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('bgColor', bgColor.value);
    prefs.setBool('isNightMode', isNightMode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 231, 230, 233),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ማስተካከያ',
              style: TextStyle(
                color: Color.fromARGB(221, 70, 71, 128),
                fontFamily: 'GeezMahtem',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Font Size Slider
            Row(
              children: [
                const Text(
                  "ፊደል መጠን: ",
                  style: TextStyle(fontFamily: 'GeezMahtem', fontSize: 15),
                ),
                Expanded(
                  child: Slider(
                    value: fontSize,
                    min: 12,
                    max: 30,
                    divisions: 18,
                    label: fontSize.toStringAsFixed(0),
                    onChanged: (value) async {
                      setState(() => fontSize = value);
                      widget.onFontSizeChanged(value);

                      final prefs = await SharedPreferences.getInstance();
                      prefs.setDouble('fontSize', value);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Font Type Dropdown
            Row(
              children: [
                const Text(
                  "ፊደል አይነት: ",
                  style: TextStyle(fontFamily: 'GeezMahtem', fontSize: 15),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: fontType,
                  items: const [
                    DropdownMenuItem(value: 'GeezMahtem', child: Text('Geez')),
                    DropdownMenuItem(value: 'jiretnn', child: Text('Jiretnn')),
                    DropdownMenuItem(value: 'Washrabsl', child: Text('Washr')),
                    DropdownMenuItem(value: 'Abyssi', child: Text('Abyssi')),
                  ],
                  onChanged: (String? value) {
                    if (value == null) return; // ignore null
                    setState(() => fontType = value);
                    widget.onFontTypeChanged(value);
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Background Color Buttons
            Row(
              children: [
                const Text(
                  "የጀርባ ቀለም: ",
                  style: TextStyle(fontFamily: 'GeezMahtem', fontSize: 15),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => updateBackground(Colors.white, false),
                  child: const Text("Light"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => updateBackground(
                      const Color.fromARGB(255, 24, 23, 23), true),
                  child: const Text("Dark"),
                ),
                const SizedBox(width: 10),
              ],
            ),

            const SizedBox(height: 30),

            // OK Button
            ElevatedButton.icon(
              onPressed: widget.onClosePanel,
              icon: const Icon(Icons.check),
              label: const Text("OK"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(221, 90, 91, 158),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
