import 'package:flutter/services.dart';

/// Haptic feedback service for premium interactions
class HapticService {
  /// Light impact - for subtle interactions like hover or selection changes
  static Future<void> lightImpact() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium impact - for button presses and toggles
  static Future<void> mediumImpact() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy impact - for important actions or confirmations
  static Future<void> heavyImpact() async {
    await HapticFeedback.heavyImpact();
  }

  /// Selection click - for picker wheels and toggles
  static Future<void> selectionClick() async {
    await HapticFeedback.selectionClick();
  }

  /// Vibrate - for notifications or alerts
  static Future<void> vibrate() async {
    await HapticFeedback.vibrate();
  }
}
