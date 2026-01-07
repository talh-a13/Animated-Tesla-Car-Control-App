import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
import 'package:flutter_animated_tesla_app/Screens/animation_config.dart';
import 'package:flutter_animated_tesla_app/Services/haptic_service.dart';
import 'package:flutter_svg/svg.dart';

class TeslaBottomNaigationBar extends StatefulWidget {
  const TeslaBottomNaigationBar({
    super.key,
    required this.selectedTab,
    required this.onTap,
  });
  
  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  State<TeslaBottomNaigationBar> createState() => _TeslaBottomNaigationBarState();
}

class _TeslaBottomNaigationBarState extends State<TeslaBottomNaigationBar> {
  void _handleTap(int index) {
    HapticService.selectionClick();
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        onTap: _handleTap,
        currentIndex: widget.selectedTab,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        elevation: 0,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: List.generate(
          navIconSrc.length,
          (index) => BottomNavigationBarItem(
            icon: _NavIcon(
              iconPath: navIconSrc[index],
              isSelected: index == widget.selectedTab,
            ),
            label: '',
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatefulWidget {
  const _NavIcon({
    required this.iconPath,
    required this.isSelected,
  });

  final String iconPath;
  final bool isSelected;

  @override
  State<_NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<_NavIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: AnimationConfig.moderate,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AnimationConfig.overshoot,
      ),
    );

    if (widget.isSelected) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_NavIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: widget.isSelected
                  ? [
                      BoxShadow(
                        color: primaryGlow.withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(
                begin: Colors.white,
                end: widget.isSelected ? primaryColor : Colors.white,
              ),
              duration: AnimationConfig.standard,
              curve: Curves.easeInOut,
              builder: (context, color, child) {
                return SvgPicture.asset(
                  widget.iconPath,
                  color: color,
                  width: 24,
                  height: 24,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

List<String> navIconSrc = [
  'assets/icons/Lock.svg',
  'assets/icons/Charge.svg',
  'assets/icons/Temp.svg',
  'assets/icons/Tyre.svg'
];

