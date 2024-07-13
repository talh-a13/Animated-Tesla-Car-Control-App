import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
import 'package:flutter_svg/svg.dart';
class DoorLock extends StatelessWidget {
  const DoorLock({
    super.key,
    required this.press,
    required this.isLock,
  });

  final VoidCallback press;
  final bool isLock;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeInOut,
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          duration: defaualtduration,
          child: isLock
              ? SvgPicture.asset(
                  'assets/icons/door_lock.svg',
                  key: const ValueKey("Lock"),
                )
              : SvgPicture.asset(
                  'assets/icons/door_unlock.svg',
                  key: const ValueKey("Unlock"),
                ),
        ));
  }
}
