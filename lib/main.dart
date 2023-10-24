import 'package:flutter/material.dart';
import 'package:flutter_dicoding/src/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// stateles data sudah final tidak bisa diubah ubah
class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

// stateful datanya dinamis bisa di ubah
class BodyText extends StatefulWidget {
  final String text;
  const BodyText({required this.text, super.key});

  @override
  State<BodyText> createState() => _BodyTextState();
}

class _BodyTextState extends State<BodyText> {
  double _textSize = 7.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.text, style: TextStyle(fontSize: _textSize)),
        const SizedBox(height: 10),
        ElevatedButton(
            child: const Text("Perbesar"),
            onPressed: () {
              setState(() {
                _textSize = 10;
              });
            })
      ],
    );
  }
}
