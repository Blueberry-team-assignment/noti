import 'package:flutter/material.dart';

class DefaultAppBarLayout extends StatelessWidget {
  final String? title;
  final Widget child;

  const DefaultAppBarLayout({
    super.key,
    this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ""),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: child,
      ),
    );
  }
}
