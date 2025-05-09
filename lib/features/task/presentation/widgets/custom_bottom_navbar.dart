import 'package:challenge_tpc/core/utils/app_colors.dart';
import 'package:challenge_tpc/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: activeIndex,
      onTap: onTap,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.backgroundColor,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Mdi.formatListText),
          label: AppStrings.task,
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.deleteSweepOutline),
          label: AppStrings.trash,
        ),
      ],
    );
  }
}
