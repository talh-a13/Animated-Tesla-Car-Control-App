import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
import 'package:flutter_svg/svg.dart';
class TempBin extends StatelessWidget {
  const TempBin({
    super.key,
    required this.svgSrc,
    this.isActive = false,
    required this.press,
    required this.title,
    this.activeColor=primaryColor
  });
  final String svgSrc, title;
  final bool isActive;
  final VoidCallback press;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutBack,
            height: isActive ? 76 : 50,
            width: isActive ? 76 : 50,
            child: SvgPicture.asset(
              svgSrc,
              color: isActive ? activeColor : Colors.white38,
            ),
          ),
          const SizedBox(
            height: defaualtpadding / 2,
          ),
          AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                  fontSize: 16,
                  color: isActive ? activeColor : Colors.white38,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
              child: Text(
                title.toUpperCase(),
              ))
        ],
      ),
    );
  }
}
