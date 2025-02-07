import 'package:flutter/material.dart';
import 'package:noti_flutter/services/go_router.dart';

class BottomNavigationBarLayout extends StatelessWidget {
  final Widget child;
  final String? title;

  const BottomNavigationBarLayout({
    super.key,
    required this.child,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ""),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              router.go('/home');
              break;
            case 1:
              router.go('/my_page');
              break;
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'MyPage',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = router.state?.matchedLocation;
    if (location?.startsWith('/home') ?? false) {
      return 0;
    }
    if (location?.startsWith('/my_page') ?? false) {
      return 1;
    }
    return 0;
  }
}
