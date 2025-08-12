// import 'package:flutter/material.dart';
// import 'package:chargerrr/core/theme/app_theme.dart';

// class AnimatedBottomBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemSelected;

//   const AnimatedBottomBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: const Color.fromARGB(255, 255, 255, 255),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildNavItem(0, Icons.home, 'Home'),
//           _buildNavItem(1, Icons.map, 'Maps'),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(int index, IconData icon, String label) {
//     final isSelected = selectedIndex == index;

//     return GestureDetector(
//       onTap: () => onItemSelected(index),
//       behavior: HitTestBehavior.opaque,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? AppTheme.primaryColor.withOpacity(0.1)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               color: isSelected ? AppTheme.primaryColor : Colors.grey,
//               size: 24,
//             ),
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               width: isSelected ? 8 : 0,
//             ),
//             AnimatedSize(
//               duration: const Duration(milliseconds: 300),
//               child: isSelected
//                   ? Text(
//                       label,
//                       style: TextStyle(
//                         color: AppTheme.primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     )
//                   : const SizedBox.shrink(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:chargerrr/core/theme/app_theme.dart';

class AnimatedBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AnimatedBottomBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Animated background indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              left: selectedIndex == 0 ? 12 : null,
              right: selectedIndex == 1 ? 12 : null,
              top: 8,
              bottom: 8,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.15),
                      AppTheme.primaryColor.withOpacity(0.08),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            // Navigation items
            Row(
              children: [
                Expanded(child: _buildNavItem(0, Icons.home_rounded, 'Home')),
                Expanded(child: _buildNavItem(1, Icons.map_rounded, 'Maps')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with scale animation
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryColor.withOpacity(0.2)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? AppTheme.primaryColor
                      : Colors.grey.shade500,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Label with fade animation
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isSelected ? 12 : 0,
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
