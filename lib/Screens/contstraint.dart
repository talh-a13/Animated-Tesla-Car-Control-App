import 'package:flutter/material.dart';

// Primary Colors
const Color primaryColor = Color(0xFF53F9FF);
const Color secondaryColor = Color(0xFFFF5368);

// Padding
const defaualtpadding = 16.0;

// Animation Durations
const Duration defaualtduration = Duration(milliseconds: 300);
const Duration quickDuration = Duration(milliseconds: 200);
const Duration slowDuration = Duration(milliseconds: 500);
const Duration verySlowDuration = Duration(milliseconds: 800);

// Glow Colors
const Color primaryGlow = Color(0xFF53F9FF);
const Color secondaryGlow = Color(0xFFFF5368);
const Color coolGlow = Color(0xFF4DD0E1);
const Color hotGlow = Color(0xFFFF6B6B);
const Color batteryGlow = Color(0xFF76FF03);
const Color warningGlow = Color(0xFFFFD54F);

// Gradients
const LinearGradient primaryGradient = LinearGradient(
  colors: [Color(0xFF53F9FF), Color(0xFF4DD0E1)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient secondaryGradient = LinearGradient(
  colors: [Color(0xFFFF5368), Color(0xFFFF6B6B)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient coolGradient = LinearGradient(
  colors: [Color(0xFF4DD0E1), Color(0xFF26C6DA), Color(0xFF00ACC1)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const LinearGradient hotGradient = LinearGradient(
  colors: [Color(0xFFFF6B6B), Color(0xFFFF5252), Color(0xFFFF1744)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

// Shadow Presets
const List<BoxShadow> softShadow = [
  BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 8,
    offset: Offset(0, 2),
  ),
];

const List<BoxShadow> mediumShadow = [
  BoxShadow(
    color: Color(0x33000000),
    blurRadius: 12,
    offset: Offset(0, 4),
  ),
];

const List<BoxShadow> strongShadow = [
  BoxShadow(
    color: Color(0x4D000000),
    blurRadius: 16,
    offset: Offset(0, 6),
  ),
];

// Glow Shadow Presets
List<BoxShadow> primaryGlowShadow = [
  BoxShadow(
    color: primaryGlow.withOpacity(0.4),
    blurRadius: 20,
    spreadRadius: 2,
  ),
];

List<BoxShadow> secondaryGlowShadow = [
  BoxShadow(
    color: secondaryGlow.withOpacity(0.4),
    blurRadius: 20,
    spreadRadius: 2,
  ),
];

List<BoxShadow> batteryGlowShadow = [
  BoxShadow(
    color: batteryGlow.withOpacity(0.4),
    blurRadius: 20,
    spreadRadius: 2,
  ),
];
