import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Model/Typespis.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
import 'package:flutter_animated_tesla_app/Screens/animation_config.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/animated_widgets.dart';

class typepsicard extends StatefulWidget {
  const typepsicard({
    super.key,
    required this.isBottomTwotyre,
    required this.tyrepsi,
  });
  
  final bool isBottomTwotyre;
  final Typepsi tyrepsi;

  @override
  State<typepsicard> createState() => _typepsicardState();
}

class _typepsicardState extends State<typepsicard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late List<Animation<double>> _staggeredAnimations;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Staggered animations for content
    _staggeredAnimations = List.generate(3, (index) {
      final start = index * 0.15;
      final end = (start + 0.4).clamp(0.0, 1.0);
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
        return Opacity(
          opacity: _fadeAnimation.value,
          child: AnimatedContainer(
            duration: AnimationConfig.standard,
            padding: const EdgeInsets.all(defaualtpadding),
            decoration: BoxDecoration(
              color: widget.tyrepsi.isLowpressure
                  ? secondaryColor.withOpacity(0.1)
                  : Colors.white10,
              border: Border.all(
                color: widget.tyrepsi.isLowpressure ? secondaryColor : primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: widget.tyrepsi.isLowpressure
                  ? [
                      BoxShadow(
                        color: secondaryGlow.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: widget.isBottomTwotyre
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: Offset(0, 10 * (1 - _staggeredAnimations[0].value)),
                        child: Opacity(
                          opacity: _staggeredAnimations[0].value,
                          child: lowpressureText(context),
                        ),
                      ),
                      const Spacer(),
                      Transform.translate(
                        offset: Offset(0, 10 * (1 - _staggeredAnimations[1].value)),
                        child: Opacity(
                          opacity: _staggeredAnimations[1].value,
                          child: psiMethod(context, psi: widget.tyrepsi.psi.toString()),
                        ),
                      ),
                      const SizedBox(
                        height: defaualtpadding,
                      ),
                      Transform.translate(
                        offset: Offset(0, 10 * (1 - _staggeredAnimations[2].value)),
                        child: Opacity(
                          opacity: _staggeredAnimations[2].value,
                          child: AnimatedCounter(
                            value: widget.tyrepsi.temp,
                            suffix: '°C',
                            duration: AnimationConfig.moderate,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: Offset(0, 10 * (1 - _staggeredAnimations[0].value)),
                        child: Opacity(
                          opacity: _staggeredAnimations[0].value,
                          child: psiMethod(context, psi: widget.tyrepsi.psi.toString()),
                        ),
                      ),
                      const SizedBox(
                        height: defaualtpadding,
                      ),
                      Transform.translate(
                        offset: Offset(0, 10 * (1 - _staggeredAnimations[1].value)),
                        child: Opacity(
                          opacity: _staggeredAnimations[1].value,
                          child: AnimatedCounter(
                            value: widget.tyrepsi.temp,
                            suffix: '°C',
                            duration: AnimationConfig.moderate,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Transform.translate(
                        offset: Offset(0, 10 * (1 - _staggeredAnimations[2].value)),
                        child: Opacity(
                          opacity: _staggeredAnimations[2].value,
                          child: lowpressureText(context),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget lowpressureText(BuildContext context) {
    if (!widget.tyrepsi.isLowpressure) {
      return const SizedBox.shrink();
    }

    return AnimatedGlow(
      glowColor: secondaryGlow,
      glowRadius: 15,
      isGlowing: true,
      duration: const Duration(milliseconds: 1500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Low'.toUpperCase(),
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
          ),
          Text(
            'Pressure'.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Widget psiMethod(BuildContext context, {required String psi}) {
    return AnimatedDoubleCounter(
      value: widget.tyrepsi.psi,
      suffix: ' psi',
      decimals: 1,
      duration: AnimationConfig.moderate,
      textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

