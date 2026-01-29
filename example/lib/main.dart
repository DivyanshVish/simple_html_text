import 'package:flutter/material.dart';
import 'package:simple_html_text/simple_html_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HtmlDemo(),
    );
  }
}

class HtmlDemo extends StatelessWidget {
  const HtmlDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7FA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Simple Html Text"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Rendered Output",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                  )
                ],
              ),
              child: HtmlText(
                'Hello <b>Bold</b> <i>Italic</i> <u>Underline</u>\n\n'
                    '<color=#FF0000>Red</color> '
                    '<size=22>Big Text</size>\n\n'
                    '<lineThrough>Strike</lineThrough>',
                baseStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Input String",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const SelectableText(
                'Hello <b>Bold</b> <i>Italic</i> <u>Underline</u>\n'
                    '<color=#FF0000>Red</color> <size=22>Big Text</size>',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
