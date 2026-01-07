import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
import 'package:flutter_animated_tesla_app/Screens/animation_config.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/animated_widgets.dart';
import 'package:flutter_animated_tesla_app/Services/haptic_service.dart';
import 'package:flutter_svg/svg.dart';

class DoorLock extends StatefulWidget {
  const DoorLock({
    super.key,
    required this.press,
    required this.isLock,
  });

  final VoidCallback press;
  final bool isLock;

  @override
  State<DoorLock> createState() => _DoorLockState();
}

class _DoorLockState extends State<DoorLock>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _glowController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    
    // Spring-based scale animation
    _scaleController = AnimationController(
      vsync: this,
      duration: AnimationConfig.moderate,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: AnimationConfig.overshoot,
      ),
    );

    // Rotation wiggle animation
    _rotationController = AnimationController(
      vsync: this,
      duration: AnimationConfig.quick,
    );
    _rotationAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOut,
      ),
    );

    // Glow pulse animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(DoorLock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLock != oldWidget.isLock) {
      _playAnimation();
    }
  }

  void _playAnimation() async {
    // Scale up with spring
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });
    
    // Wiggle rotation
    _rotationController.repeat(reverse: true, period: const Duration(milliseconds: 100));
    await Future.delayed(const Duration(milliseconds: 300));
    _rotationController.stop();
    _rotationController.value = 0;
    
    // Glow pulse
    _glowController.forward().then((_) {
      _glowController.reverse();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticService.mediumImpact();
    widget.press();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleController, _rotationController, _glowController]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (widget.isLock ? primaryGlow : secondaryGlow)
                          .withOpacity(_glowAnimation.value * 0.6),
                      blurRadius: 15 + _glowAnimation.value * 10,
                      spreadRadius: 2 + _glowAnimation.value * 3,
                    ),
                  ],
                ),
                child: AnimatedSwitcher(
                  switchInCurve: AnimationConfig.overshoot,
                  switchOutCurve: AnimationConfig.overshoot,
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: RotationTransition(
                        turns: Tween<double>(begin: 0.0, end: 0.125).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  duration: slowDuration,
                  child: widget.isLock
                      ? SvgPicture.asset(
                          'assets/icons/door_lock.svg',
                          key: const ValueKey("Lock"),
                        )
                      : SvgPicture.asset(
                          'assets/icons/door_unlock.svg',
                          key: const ValueKey("Unlock"),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

