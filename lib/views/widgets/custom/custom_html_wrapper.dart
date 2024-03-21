import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomHtmlWrapper extends StatelessWidget {
  const CustomHtmlWrapper({
    super.key,
    required this.data,
  });
  final String data;
  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
    );
  }
}
