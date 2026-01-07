import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
import 'package:flutter_animated_tesla_app/Screens/animation_config.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/animated_widgets.dart';

class BatteryStatus extends StatefulWidget {
  const BatteryStatus({
    super.key,
    required this.constrains,
  });
  
  final BoxConstraints constrains;

  @override
  State<BatteryStatus> createState() => _BatteryStatusState();
}

class _BatteryStatusState extends State<BatteryStatus>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late List<Animation<double>> _staggeredAnimations;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Create staggered animations for text elements
    _staggeredAnimations = List.generate(5, (index) {
      final start = 0.1 + (index * 0.1);
      final end = (start + 0.3).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    _controller.forward();
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
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Column(
              children: [
                // Miles counter with animation
                Transform.translate(
                  offset: Offset(0, 20 * (1 - _staggeredAnimations[0].value)),
                  child: Opacity(
                    opacity: _staggeredAnimations[0].value,
                    child: AnimatedCounter(
                      value: 220,
                      suffix: ' mi',
                      duration: const Duration(milliseconds: 1500),
                      textStyle: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Percentage with glow
                Transform.translate(
                  offset: Offset(0, 20 * (1 - _staggeredAnimations[1].value)),
                  child: Opacity(
                    opacity: _staggeredAnimations[1].value,
                    child: AnimatedGlow(
                      glowColor: batteryGlow,
                      glowRadius: 25,
                      isGlowing: true,
                      duration: const Duration(milliseconds: 2000),
                      child: AnimatedCounter(
                        value: 62,
                        suffix: ' %',
                        duration: const Duration(milliseconds: 1500),
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Charging status with shimmer
                Transform.translate(
                  offset: Offset(0, 20 * (1 - _staggeredAnimations[2].value)),
                  child: Opacity(
                    opacity: _staggeredAnimations[2].value,
                    child: AnimatedShimmer(
                      baseColor: primaryColor.withOpacity(0.3),
                      highlightColor: primaryColor.withOpacity(0.6),
                      child: Text(
                        'CHARGING',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Time remaining
                Transform.translate(
                  offset: Offset(0, 20 * (1 - _staggeredAnimations[3].value)),
                  child: Opacity(
                    opacity: _staggeredAnimations[3].value,
                    child: AnimatedCounter(
                      value: 18,
                      suffix: ' min remaining',
                      duration: const Duration(milliseconds: 1500),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: widget.constrains.maxHeight * 0.14),
                
                // Stats row
                Transform.translate(
                  offset: Offset(0, 20 * (1 - _staggeredAnimations[4].value)),
                  child: Opacity(
                    opacity: _staggeredAnimations[4].value,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedCounter(
                            value: 22,
                            suffix: ' mi/hr',
                            duration: const Duration(milliseconds: 1500),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                          AnimatedCounter(
                            value: 232,
                            suffix: ' v',
                            duration: const Duration(milliseconds: 1500),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: defaualtpadding),
              ],
            ),
          ),
        );
      },
    );
  }
}

