import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("HELLO FLUTTER"),
        ),
        body: const Center(
          child: Text("HELLO WORLD!"),
        ),
      ),
    );
  }
}
