/// A lightweight Flutter library for rendering simple HTML-styled text.
///
/// This library provides the [HtmlText] widget, which parses basic HTML tags
/// and renders styled text using Flutter's [RichText] widget.
///
/// ## Supported HTML Tags
///
/// The following HTML tags are supported:
/// - `<b>` - Bold text
/// - `<i>` - Italic text
/// - `<u>` - Underlined text
/// - `<lineThrough>` - Strikethrough text
/// - `<color=#RRGGBB>` - Colored text (hex format)
/// - `<size=N>` - Custom font size
///
/// ## Example
///
/// ```dart
/// HtmlText(
///   '<b>Bold</b> and <i>Italic</i> text with <color=#FF5733>color</color>',
///   baseStyle: TextStyle(fontSize: 16, color: Colors.black),
/// )
/// ```
library simple_html_text;

export 'src/html_text.dart';
