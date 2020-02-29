import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/views/user_interfaces/screens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
