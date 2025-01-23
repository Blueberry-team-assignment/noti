import 'package:flutter/material.dart';
import 'package:noti_flutter/router/go_router.dart';

class BottomNavigationBarLayout extends StatelessWidget {
  final Widget child;

  const BottomNavigationBarLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              router.go('/home');
              break;
            case 1:
              router.go('/flow');
              break;
            case 2:
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
            icon: Icon(Icons.schedule),
            label: 'Flow',
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
    if (location?.startsWith('/flow') ?? false) {
      return 1;
    }
    if (location?.startsWith('/my_page') ?? false) {
      return 2;
    }
    return 0;
  }
}
