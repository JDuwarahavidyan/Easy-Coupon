import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;
  ThemeProvider(this._themeData);

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    if (_themeData == ThemeData.light()) {
      _themeData = ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        // Define other dark theme properties
      );
    } else {
      _themeData = ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF9E6BD),
        // Define other light theme properties
      );
    }
    notifyListeners();
  }
}

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: Provider.of<ThemeProvider>(context).themeData == ThemeData.dark(),
      onChanged: (value) {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      },
      activeColor: Colors.white,
      inactiveThumbColor: Colors.black,
      inactiveTrackColor: Colors.grey,
    );
  }
}
