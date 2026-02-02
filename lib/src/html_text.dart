import 'package:flutter/material.dart';

/// A Flutter widget that renders HTML-styled text using [RichText].
///
/// [HtmlText] parses a string containing basic HTML tags and converts them
/// into styled [TextSpan] elements. This is useful for displaying formatted
/// text received from APIs or user input without requiring a full HTML renderer.
///
/// ## Supported Tags
///
/// | Tag | Description |
/// |-----|-------------|
/// | `<b>` | Bold text |
/// | `<i>` | Italic text |
/// | `<u>` | Underlined text |
/// | `<lineThrough>` | Strikethrough text |
/// | `<color=#RRGGBB>` | Custom text color (6-digit hex) |
/// | `<size=N>` | Custom font size in pixels |
///
/// ## Example
///
/// ```dart
/// HtmlText(
///   '<b>Important:</b> Please read the <color=#0066CC>terms</color>',
///   baseStyle: TextStyle(fontSize: 14, color: Colors.black87),
/// )
/// ```
///
/// See also:
///
///  * [RichText], the underlying widget used for rendering.
///  * [TextSpan], which represents each styled segment of text.
class HtmlText extends StatelessWidget {
  /// The HTML-formatted string to be parsed and rendered.
  ///
  /// This string may contain supported HTML tags such as `<b>`, `<i>`, `<u>`,
  /// `<lineThrough>`, `<color=#RRGGBB>`, and `<size=N>`. Unsupported tags
  /// will be ignored, and their content will be rendered with the current style.
  ///
  /// Example:
  /// ```dart
  /// '<b>Bold</b> text with <i>italic</i>'
  /// ```
  final String text;

  /// The base [TextStyle] applied to all text in the widget.
  ///
  /// This style serves as the foundation for all rendered text. HTML tags
  /// modify this base style (e.g., `<b>` adds [FontWeight.bold] to this style).
  ///
  /// Example:
  /// ```dart
  /// TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Roboto')
  /// ```
  final TextStyle baseStyle;

  /// Creates an [HtmlText] widget that parses and renders HTML-styled text.
  ///
  /// The [text] parameter is the HTML-formatted string to render.
  ///
  /// The [baseStyle] parameter is required and defines the default text style
  /// that HTML tags will modify.
  ///
  /// Example:
  /// ```dart
  /// HtmlText(
  ///   '<b>Welcome</b> to <color=#FF5733>Flutter</color>!',
  ///   baseStyle: TextStyle(fontSize: 18, color: Colors.grey),
  /// )
  /// ```
  const HtmlText(this.text, {super.key, required this.baseStyle});

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
        spans.add(
          TextSpan(
            text: input.substring(index, match.start),
            style: stack.last,
          ),
        );
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
