import 'package:flutter/material.dart';

class HeadlineLarge extends StatelessWidget {
  final String text;
  const HeadlineLarge({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
