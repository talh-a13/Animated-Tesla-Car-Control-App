import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_animated_tesla_app/Screens/animation_config.dart';

/// Animated glow effect widget
class AnimatedGlow extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double glowRadius;
  final bool isGlowing;
  final Duration duration;

  const AnimatedGlow({
    super.key,
    required this.child,
    this.glowColor = Colors.cyan,
    this.glowRadius = 20.0,
    this.isGlowing = true,
    this.duration = AnimationConfig.standard,
  });

  @override
  State<AnimatedGlow> createState() => _AnimatedGlowState();
}

class _AnimatedGlowState extends State<AnimatedGlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    
    if (widget.isGlowing) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AnimatedGlow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isGlowing != oldWidget.isGlowing) {
      if (widget.isGlowing) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = 0;
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
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: widget.isGlowing
                ? [
                    BoxShadow(
                      color: widget.glowColor.withOpacity(0.3 + _animation.value * 0.4),
                      blurRadius: widget.glowRadius * (0.5 + _animation.value * 0.5),
                      spreadRadius: 2 + _animation.value * 3,
                    ),
                  ]
                : null,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Animated ripple effect
class AnimatedRipple extends StatefulWidget {
  final Widget child;
  final Color rippleColor;
  final Duration duration;
  final VoidCallback? onTap;

  const AnimatedRipple({
    super.key,
    required this.child,
    this.rippleColor = Colors.white,
    this.duration = AnimationConfig.moderate,
    this.onTap,
  });

  @override
  State<AnimatedRipple> createState() => _AnimatedRippleState();
}

class _AnimatedRippleState extends State<AnimatedRipple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0.0);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.rippleColor.withOpacity(_opacityAnimation.value),
                  ),
                ),
              );
            },
          ),
          widget.child,
        ],
      ),
    );
  }
}

/// Animated counter with rolling digits
class AnimatedCounter extends StatelessWidget {
  final int value;
  final TextStyle? textStyle;
  final Duration duration;
  final String? suffix;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.textStyle,
    this.duration = AnimationConfig.moderate,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: duration,
      curve: AnimationConfig.smooth,
      builder: (context, value, child) {
        return Text(
          suffix != null ? '$value$suffix' : '$value',
          style: textStyle,
        );
      },
    );
  }
}

/// Animated counter for double values
class AnimatedDoubleCounter extends StatelessWidget {
  final double value;
  final TextStyle? textStyle;
  final Duration duration;
  final String? suffix;
  final int decimals;

  const AnimatedDoubleCounter({
    super.key,
    required this.value,
    this.textStyle,
    this.duration = AnimationConfig.moderate,
    this.suffix,
    this.decimals = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: duration,
      curve: AnimationConfig.smooth,
      builder: (context, value, child) {
        return Text(
          suffix != null 
              ? '${value.toStringAsFixed(decimals)}$suffix' 
              : value.toStringAsFixed(decimals),
          style: textStyle,
        );
      },
    );
  }
}

/// Shimmer loading effect
class AnimatedShimmer extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const AnimatedShimmer({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFF1A1A1A),
    this.highlightColor = const Color(0xFF2A2A2A),
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<AnimatedShimmer> createState() => _AnimatedShimmerState();
}

class _AnimatedShimmerState extends State<AnimatedShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
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
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Particle effect widget
class AnimatedParticles extends StatefulWidget {
  final int particleCount;
  final Color particleColor;
  final double particleSize;
  final Duration duration;

  const AnimatedParticles({
    super.key,
    this.particleCount = 20,
    this.particleColor = Colors.cyan,
    this.particleSize = 4.0,
    this.duration = const Duration(milliseconds: 2000),
  });

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    
    _particles = List.generate(
      widget.particleCount,
      (index) => Particle(
        angle: (index / widget.particleCount) * 2 * math.pi,
        speed: 50 + math.Random().nextDouble() * 50,
      ),
    );
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
      builder: (context, _) {
        return CustomPaint(
          painter: ParticlePainter(
            particles: _particles,
            progress: _controller.value,
            color: widget.particleColor,
            size: widget.particleSize,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  final double angle;
  final double speed;

  Particle({required this.angle, required this.speed});
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;
  final Color color;
  final double size;

  ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()..color = color;
    final center = Offset(canvasSize.width / 2, canvasSize.height / 2);

    for (var particle in particles) {
      final distance = particle.speed * progress;
      final x = center.dx + math.cos(particle.angle) * distance;
      final y = center.dy + math.sin(particle.angle) * distance;
      final opacity = 1.0 - progress;
      
      paint.color = color.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

/// Animated gradient border
class AnimatedGradientBorder extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final double borderWidth;
  final Duration duration;
  final BorderRadius? borderRadius;

  const AnimatedGradientBorder({
    super.key,
    required this.child,
    required this.colors,
    this.borderWidth = 2.0,
    this.duration = const Duration(milliseconds: 2000),
    this.borderRadius,
  });

  @override
  State<AnimatedGradientBorder> createState() => _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends State<AnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
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
        return Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: SweepGradient(
              colors: widget.colors,
              transform: GradientRotation(_controller.value * 2 * math.pi),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(widget.borderWidth),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              color: Colors.black,
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Spring-based button with physics
class SpringButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double scaleDown;

  const SpringButton({
    super.key,
    required this.child,
    this.onPressed,
    this.scaleDown = 0.95,
  });

  @override
  State<SpringButton> createState() => _SpringButtonState();
}

class _SpringButtonState extends State<SpringButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimationConfig.quick,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleDown).animate(
      CurvedAnimation(parent: _controller, curve: AnimationConfig.spring),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}

/// Staggered list animation
class StaggeredList extends StatefulWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final Curve curve;
  final Axis direction;

  const StaggeredList({
    super.key,
    required this.children,
    this.staggerDelay = AnimationConfig.staggerDelay,
    this.curve = Curves.easeOut,
    this.direction = Axis.vertical,
  });

  @override
  State<StaggeredList> createState() => _StaggeredListState();
}

class _StaggeredListState extends State<StaggeredList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.staggerDelay * widget.children.length + AnimationConfig.moderate,
    );
    
    _animations = AnimationBuilders.staggered(
      controller: _controller,
      count: widget.children.length,
      staggerDelay: widget.staggerDelay,
      curve: widget.curve,
    );
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.children.length, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Opacity(
              opacity: _animations[index].value,
              child: Transform.translate(
                offset: widget.direction == Axis.vertical
                    ? Offset(0, 20 * (1 - _animations[index].value))
                    : Offset(20 * (1 - _animations[index].value), 0),
                child: child,
              ),
            );
          },
          child: widget.children[index],
        );
      }),
    );
  }
}
