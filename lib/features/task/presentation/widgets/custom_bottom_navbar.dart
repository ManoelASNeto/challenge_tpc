import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Mdi.accessPoint),
      ),
    );
  }
}

class CustomBottomNavbar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  static final List<IconData> iconList = [
    Mdi.formatListText,
    Mdi.playlistRemove,
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: iconList,
      activeIndex: activeIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.sharpEdge,
      onTap: onTap,
    );
  }
}
