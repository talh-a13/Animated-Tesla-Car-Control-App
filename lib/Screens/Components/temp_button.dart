import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
import 'package:flutter_animated_tesla_app/Screens/animation_config.dart';
import 'package:flutter_animated_tesla_app/Services/haptic_service.dart';
import 'package:flutter_svg/svg.dart';

class TempBin extends StatefulWidget {
  const TempBin({
    super.key,
    required this.svgSrc,
    this.isActive = false,
    required this.press,
    required this.title,
    this.activeColor = primaryColor,
  });
  
  final String svgSrc, title;
  final bool isActive;
  final VoidCallback press;
  final Color activeColor;

  @override
  State<TempBin> createState() => _TempBinState();
}

class _TempBinState extends State<TempBin>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _glowController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    _scaleController = AnimationController(
      vsync: this,
      duration: AnimationConfig.moderate,
    );
    _scaleAnimation = Tween<double>(begin: 50.0, end: 76.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: AnimationConfig.overshoot,
      ),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: AnimationConfig.moderate,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOut,
      ),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.isActive) {
      _scaleController.value = 1.0;
      _rotationController.value = 1.0;
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(TempBin oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _scaleController.forward();
        _rotationController.forward();
        _glowController.repeat(reverse: true);
      } else {
        _scaleController.reverse();
        _rotationController.reverse();
        _glowController.stop();
        _glowController.value = 0;
      }
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticService.selectionClick();
    widget.press();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([_scaleController, _rotationController, _glowController]),
            builder: (context, child) {
              return Container(
                height: _scaleAnimation.value,
                width: _scaleAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: widget.isActive
                      ? [
                          BoxShadow(
                            color: widget.activeColor.withOpacity(0.3 + _glowController.value * 0.3),
                            blurRadius: 15 + _glowController.value * 10,
                            spreadRadius: 2 + _glowController.value * 3,
                          ),
                        ]
                      : null,
                ),
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 0.1,
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: Colors.white38,
                      end: widget.isActive ? widget.activeColor : Colors.white38,
                    ),
                    duration: AnimationConfig.standard,
                    curve: Curves.easeInOut,
                    builder: (context, color, child) {
                      return SvgPicture.asset(
                        widget.svgSrc,
                        color: color,
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: defaualtpadding / 2,
          ),
          TweenAnimationBuilder<TextStyle>(
            tween: TextStyleTween(
              begin: const TextStyle(
                fontSize: 16,
                color: Colors.white38,
                fontWeight: FontWeight.normal,
              ),
              end: TextStyle(
                fontSize: 16,
                color: widget.isActive ? widget.activeColor : Colors.white38,
                fontWeight: widget.isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            duration: AnimationConfig.standard,
            curve: Curves.easeInOut,
            builder: (context, textStyle, child) {
              return Text(
                widget.title.toUpperCase(),
                style: textStyle,
              );
            },
          ),
        ],
      ),
    );
  }
}

