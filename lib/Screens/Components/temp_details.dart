import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/temp_button.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
import 'package:flutter_animated_tesla_app/Screens/animation_config.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/animated_widgets.dart';
import 'package:flutter_animated_tesla_app/Services/haptic_service.dart';
import 'package:flutter_animated_tesla_app/Screens/homecontroller.dart';

class Tempdetails extends StatefulWidget {
  const Tempdetails({
    super.key,
    required homecontroller controller,
  }) : _controller = controller;

  final homecontroller _controller;

  @override
  State<Tempdetails> createState() => _TempdetailsState();
}

class _TempdetailsState extends State<Tempdetails> {
  int _currentTemp = 29;

  void _incrementTemp() {
    HapticService.lightImpact();
    setState(() {
      if (_currentTemp < 35) _currentTemp++;
    });
  }

  void _decrementTemp() {
    HapticService.lightImpact();
    setState(() {
      if (_currentTemp > 15) _currentTemp--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaualtpadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBin(
                  isActive: widget._controller.isCoolSelected,
                  svgSrc: 'assets/icons/coolShape.svg',
                  title: 'Cool',
                  press: widget._controller.updateCoolSelectedTab,
                ),
                const SizedBox(
                  width: defaualtpadding,
                ),
                TempBin(
                  isActive: !widget._controller.isCoolSelected,
                  svgSrc: 'assets/icons/heatShape.svg',
                  title: 'Heat',
                  activeColor: hotGlow,
                  press: widget._controller.updateCoolSelectedTab,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              SpringButton(
                onPressed: _incrementTemp,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_drop_up,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedGlow(
                glowColor: widget._controller.isCoolSelected ? coolGlow : hotGlow,
                glowRadius: 30,
                isGlowing: true,
                duration: const Duration(milliseconds: 2000),
                child: AnimatedCounter(
                  value: _currentTemp,
                  suffix: '°C',
                  duration: AnimationConfig.quick,
                  textStyle: const TextStyle(
                    fontSize: 89,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SpringButton(
                onPressed: _decrementTemp,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_drop_down,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            'CURRENT TEMPERATURE',
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 1.5,
              color: Colors.white70,
            ),
          ),
          const SizedBox(
            height: defaualtpadding,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INSIDE'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedCounter(
                    value: 20,
                    suffix: '°C',
                    duration: AnimationConfig.moderate,
                    textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                width: defaualtpadding * 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OUTSIDE'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedCounter(
                    value: 35,
                    suffix: '°C',
                    duration: AnimationConfig.moderate,
                    textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

