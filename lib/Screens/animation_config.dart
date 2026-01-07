import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Centralized animation configuration for premium animations
class AnimationConfig {
  // Animation Durations
  static const Duration micro = Duration(milliseconds: 100);
  static const Duration quick = Duration(milliseconds: 200);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration moderate = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 800);
  static const Duration glacial = Duration(milliseconds: 1200);

  // Spring Physics Configurations
  static const SpringDescription defaultSpring = SpringDescription(
    mass: 1.0,
    stiffness: 180.0,
    damping: 12.0,
  );

  static const SpringDescription bouncySpring = SpringDescription(
    mass: 1.0,
    stiffness: 100.0,
    damping: 8.0,
  );

  static const SpringDescription gentleSpring = SpringDescription(
    mass: 1.0,
    stiffness: 200.0,
    damping: 20.0,
  );

  static const SpringDescription stiffSpring = SpringDescription(
    mass: 0.5,
    stiffness: 300.0,
    damping: 15.0,
  );

  // Custom Curves
  static const Curve spring = Curves.easeOutBack;
  static const Curve elastic = Curves.elasticOut;
  static const Curve bounce = Curves.bounceOut;
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve snappy = Curves.easeOutExpo;
  static const Curve gentle = Curves.easeInOutQuad;
  
  // Custom bezier curves
  static const Curve customElastic = Cubic(0.68, -0.55, 0.265, 1.55);
  static const Curve anticipate = Cubic(0.36, 0, 0.66, -0.56);
  static const Curve overshoot = Cubic(0.34, 1.56, 0.64, 1);
  
  // Stagger Configuration
  static const Duration staggerDelay = Duration(milliseconds: 50);
  static const Duration staggerDelayLong = Duration(milliseconds: 100);
  
  /// Calculate staggered delay for index
  static Duration getStaggerDelay(int index, {Duration baseDelay = staggerDelay}) {
    return baseDelay * index;
  }
  
  /// Create a spring simulation
  static SpringSimulation createSpringSimulation({
    required double start,
    required double end,
    required double velocity,
    SpringDescription spring = defaultSpring,
  }) {
    return SpringSimulation(spring, start, end, velocity);
  }
}

/// Custom curve that combines multiple curves
class CombinedCurve extends Curve {
  final Curve firstCurve;
  final Curve secondCurve;
  final double threshold;

  const CombinedCurve({
    required this.firstCurve,
    required this.secondCurve,
    this.threshold = 0.5,
  });

  @override
  double transformInternal(double t) {
    if (t < threshold) {
      return firstCurve.transform(t / threshold) * threshold;
    } else {
      return threshold + secondCurve.transform((t - threshold) / (1 - threshold)) * (1 - threshold);
    }
  }
}

/// Animation builder helpers
class AnimationBuilders {
  /// Create a delayed animation
  static Animation<double> delayed({
    required AnimationController controller,
    required Duration delay,
    Duration? duration,
    Curve curve = Curves.linear,
  }) {
    final totalDuration = controller.duration!.inMilliseconds;
    final delayMs = delay.inMilliseconds;
    final animDuration = duration?.inMilliseconds ?? (totalDuration - delayMs);
    
    final begin = delayMs / totalDuration;
    final end = (delayMs + animDuration) / totalDuration;
    
    return CurvedAnimation(
      parent: controller,
      curve: Interval(begin, end.clamp(0.0, 1.0), curve: curve),
    );
  }
  
  /// Create a staggered animation for a list
  static List<Animation<double>> staggered({
    required AnimationController controller,
    required int count,
    Duration staggerDelay = AnimationConfig.staggerDelay,
    Curve curve = Curves.easeOut,
  }) {
    return List.generate(count, (index) {
      return delayed(
        controller: controller,
        delay: staggerDelay * index,
        curve: curve,
      );
    });
  }
}

/// Tween helpers for common animations
class AnimationTweens {
  static Tween<double> scale({double begin = 0.0, double end = 1.0}) {
    return Tween<double>(begin: begin, end: end);
  }
  
  static Tween<double> rotation({double begin = 0.0, double end = 1.0}) {
    return Tween<double>(begin: begin, end: end);
  }
  
  static Tween<Offset> slide({
    Offset begin = const Offset(0, 1),
    Offset end = Offset.zero,
  }) {
    return Tween<Offset>(begin: begin, end: end);
  }
  
  static Tween<double> opacity({double begin = 0.0, double end = 1.0}) {
    return Tween<double>(begin: begin, end: end);
  }
  
  static ColorTween color({required Color begin, required Color end}) {
    return ColorTween(begin: begin, end: end);
  }
}
