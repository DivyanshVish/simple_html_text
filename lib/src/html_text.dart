import 'package:flutter/material.dart';

class HtmlText extends StatelessWidget {
  final String text;
  final TextStyle baseStyle;

  const HtmlText(
      this.text, {
        super.key,
        required this.baseStyle,
      });

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(children: _parse(text, baseStyle)));
  }

  List<TextSpan> _parse(String input, TextStyle base) {
    final spans = <TextSpan>[];
    final stack = <TextStyle>[base];

    final tagReg = RegExp(r'<\/?[^>]+>');
    int index = 0;

    for (final match in tagReg.allMatches(input)) {
      if (match.start > index) {
        spans.add(TextSpan(
          text: input.substring(index, match.start),
          style: stack.last,
        ));
      }

      final tag = input.substring(match.start, match.end);

      if (tag.startsWith("</")) {
        if (stack.length > 1) stack.removeLast();
      } else {
        var style = stack.last;

        if (tag == "<b>") {
          style = style.copyWith(fontWeight: FontWeight.bold);
        } else if (tag == "<i>") {
          style = style.copyWith(fontStyle: FontStyle.italic);
        } else if (tag == "<u>") {
          style = style.copyWith(decoration: TextDecoration.underline);
        } else if (tag == "<lineThrough>") {
          style = style.copyWith(decoration: TextDecoration.lineThrough);
        } else if (tag.startsWith("<color=")) {
          final hex = RegExp(r'#([0-9A-Fa-f]{6})').firstMatch(tag)!.group(1)!;
          style = style.copyWith(color: Color(int.parse("0xff$hex")));
        } else if (tag.startsWith("<size=")) {
          final size = RegExp(r'\d+').firstMatch(tag)!.group(0)!;
          style = style.copyWith(fontSize: double.parse(size));
        }

        stack.add(style);
      }

      index = match.end;
    }

    if (index < input.length) {
      spans.add(TextSpan(text: input.substring(index), style: stack.last));
    }

    return spans;
  }
}
