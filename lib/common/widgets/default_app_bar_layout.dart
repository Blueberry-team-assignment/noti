import 'package:flutter/material.dart';

// 바텀 내비게이션 바가 없는 기본 레이아웃입니다.
// goRouter의 shellRoute를 사용하여 적용했습니다.
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
