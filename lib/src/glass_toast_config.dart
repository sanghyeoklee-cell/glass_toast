import 'package:flutter/material.dart';

/// Configuration for GlassToast appearance and behavior.
///
/// Use [GlassToastConfig.light] or [GlassToastConfig.dark] for preset themes,
/// or create a custom configuration.
class GlassToastConfig {
  /// Background colors for the gradient (start to end).
  final List<Color> backgroundColors;

  /// Border color of the toast.
  final Color borderColor;

  /// Text color.
  final Color textColor;

  /// Shadow color.
  final Color shadowColor;

  /// Border radius of the toast.
  final double borderRadius;

  /// Blur intensity for the glassmorphism effect.
  final double blurSigma;

  /// Maximum width of the toast.
  final double maxWidth;

  /// Padding inside the toast.
  final EdgeInsets padding;

  /// Margin from the edge of the screen.
  final double edgeMargin;

  /// Duration of the slide/fade animation.
  final Duration animationDuration;

  /// Animation curve for entry.
  final Curve animationCurve;

  /// Default icon color (used when no specific color is provided).
  final Color defaultIconColor;

  /// Text style for the message.
  final TextStyle? textStyle;

  /// Creates a custom GlassToast configuration.
  const GlassToastConfig({
    this.backgroundColors = const [
      Color(0xD9FFFFFF),
      Color(0xBFFFFFFF),
    ],
    this.borderColor = const Color(0x80FFFFFF),
    this.textColor = const Color(0xFF1F2937),
    this.shadowColor = const Color(0x1A000000),
    this.borderRadius = 16.0,
    this.blurSigma = 20.0,
    this.maxWidth = 400.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.edgeMargin = 80.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutCubic,
    this.defaultIconColor = const Color(0xFF6B7280),
    this.textStyle,
  });

  /// Light theme preset (default).
  static const GlassToastConfig light = GlassToastConfig();

  /// Dark theme preset.
  static const GlassToastConfig dark = GlassToastConfig(
    backgroundColors: [
      Color(0xD91F2937),
      Color(0xBF1F2937),
    ],
    borderColor: Color(0x40FFFFFF),
    textColor: Color(0xFFF9FAFB),
    shadowColor: Color(0x33000000),
    defaultIconColor: Color(0xFF9CA3AF),
  );

  /// Creates a copy of this config with the given fields replaced.
  GlassToastConfig copyWith({
    List<Color>? backgroundColors,
    Color? borderColor,
    Color? textColor,
    Color? shadowColor,
    double? borderRadius,
    double? blurSigma,
    double? maxWidth,
    EdgeInsets? padding,
    double? edgeMargin,
    Duration? animationDuration,
    Curve? animationCurve,
    Color? defaultIconColor,
    TextStyle? textStyle,
  }) {
    return GlassToastConfig(
      backgroundColors: backgroundColors ?? this.backgroundColors,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      shadowColor: shadowColor ?? this.shadowColor,
      borderRadius: borderRadius ?? this.borderRadius,
      blurSigma: blurSigma ?? this.blurSigma,
      maxWidth: maxWidth ?? this.maxWidth,
      padding: padding ?? this.padding,
      edgeMargin: edgeMargin ?? this.edgeMargin,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      defaultIconColor: defaultIconColor ?? this.defaultIconColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
