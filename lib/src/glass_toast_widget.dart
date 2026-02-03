import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'glass_toast_config.dart';
import 'glass_toast_position.dart';

/// A glassmorphism-style toast notification.
///
/// Use the static methods to show toasts:
/// ```dart
/// GlassToast.info(context, 'Information message');
/// GlassToast.success(context, 'Success!');
/// GlassToast.warning(context, 'Warning message');
/// GlassToast.error(context, 'Error occurred');
/// ```
///
/// Or use [GlassToast.show] for custom toasts:
/// ```dart
/// GlassToast.show(
///   context,
///   message: 'Custom message',
///   icon: Icons.star,
///   iconColor: Colors.amber,
///   position: GlassToastPosition.bottom,
///   config: GlassToastConfig.dark,
/// );
/// ```
class GlassToast {
  static OverlayEntry? _currentOverlay;
  static GlassToastConfig _defaultConfig = GlassToastConfig.light;

  /// Sets the default configuration for all toasts.
  ///
  /// Call this in your app's initialization to set a global theme:
  /// ```dart
  /// GlassToast.setDefaultConfig(GlassToastConfig.dark);
  /// ```
  static void setDefaultConfig(GlassToastConfig config) {
    _defaultConfig = config;
  }

  /// Shows a custom toast.
  ///
  /// [context] - BuildContext for overlay insertion.
  /// [message] - The text to display.
  /// [duration] - How long the toast stays visible.
  /// [icon] - Optional icon to display.
  /// [iconColor] - Color of the icon.
  /// [position] - Where the toast appears (top, center, bottom).
  /// [config] - Visual configuration (uses default if not specified).
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    IconData? icon,
    Color? iconColor,
    GlassToastPosition position = GlassToastPosition.top,
    GlassToastConfig? config,
  }) {
    // Remove previous toast
    _currentOverlay?.remove();
    _currentOverlay = null;

    final effectiveConfig = config ?? _defaultConfig;
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _GlassToastOverlay(
        message: message,
        duration: duration,
        icon: icon,
        iconColor: iconColor ?? effectiveConfig.defaultIconColor,
        position: position,
        config: effectiveConfig,
        onDismiss: () {
          _currentOverlay?.remove();
          _currentOverlay = null;
        },
      ),
    );

    _currentOverlay = overlayEntry;
    overlay.insert(overlayEntry);
  }

  /// Shows an info toast with a blue icon.
  static void info(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    GlassToastPosition position = GlassToastPosition.top,
    GlassToastConfig? config,
  }) {
    show(
      context,
      message: message,
      duration: duration,
      icon: Icons.info_outline,
      iconColor: const Color(0xFF3B82F6),
      position: position,
      config: config,
    );
  }

  /// Shows a success toast with a green icon.
  static void success(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    GlassToastPosition position = GlassToastPosition.top,
    GlassToastConfig? config,
  }) {
    show(
      context,
      message: message,
      duration: duration,
      icon: Icons.check_circle_outline,
      iconColor: const Color(0xFF10B981),
      position: position,
      config: config,
    );
  }

  /// Shows a warning toast with an amber icon.
  static void warning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    GlassToastPosition position = GlassToastPosition.top,
    GlassToastConfig? config,
  }) {
    show(
      context,
      message: message,
      duration: duration,
      icon: Icons.warning_amber_outlined,
      iconColor: const Color(0xFFF59E0B),
      position: position,
      config: config,
    );
  }

  /// Shows an error toast with a red icon.
  static void error(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    GlassToastPosition position = GlassToastPosition.top,
    GlassToastConfig? config,
  }) {
    show(
      context,
      message: message,
      duration: duration,
      icon: Icons.error_outline,
      iconColor: const Color(0xFFEF4444),
      position: position,
      config: config,
    );
  }

  /// Dismisses the currently visible toast immediately.
  static void dismiss() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}

class _GlassToastOverlay extends StatefulWidget {
  final String message;
  final Duration duration;
  final IconData? icon;
  final Color iconColor;
  final GlassToastPosition position;
  final GlassToastConfig config;
  final VoidCallback onDismiss;

  const _GlassToastOverlay({
    required this.message,
    required this.duration,
    this.icon,
    required this.iconColor,
    required this.position,
    required this.config,
    required this.onDismiss,
  });

  @override
  State<_GlassToastOverlay> createState() => _GlassToastOverlayState();
}

class _GlassToastOverlayState extends State<_GlassToastOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _autoDismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );

    final slideBegin = _getSlideBegin();
    _slideAnimation = Tween<double>(begin: slideBegin, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: widget.config.animationCurve),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    // Auto dismiss with cancellable timer
    _autoDismissTimer = Timer(widget.duration, () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  double _getSlideBegin() {
    switch (widget.position) {
      case GlassToastPosition.top:
        return -100;
      case GlassToastPosition.center:
        return 0; // No slide for center, just fade
      case GlassToastPosition.bottom:
        return 100;
    }
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _autoDismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Positioned(
      top: widget.position == GlassToastPosition.bottom ? null : 0,
      bottom: widget.position == GlassToastPosition.bottom ? 0 : null,
      left: 0,
      right: 0,
      child: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: child,
              ),
            );
          },
          child: _buildPositionedContent(config),
        ),
      ),
    );
  }

  Widget _buildPositionedContent(GlassToastConfig config) {
    final toastWidget = GestureDetector(
      onTap: _dismiss,
      child: Container(
        constraints: BoxConstraints(maxWidth: config.maxWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(config.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: config.blurSigma,
              sigmaY: config.blurSigma,
            ),
            child: Container(
              padding: config.padding,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: config.backgroundColors,
                ),
                borderRadius: BorderRadius.circular(config.borderRadius),
                border: Border.all(
                  color: config.borderColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: config.shadowColor,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 22,
                      color: widget.iconColor,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Flexible(
                    child: Text(
                      widget.message,
                      style: config.textStyle ??
                          TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: config.textColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    switch (widget.position) {
      case GlassToastPosition.top:
        return Container(
          margin: EdgeInsets.only(top: config.edgeMargin),
          child: Center(child: toastWidget),
        );
      case GlassToastPosition.center:
        return Center(child: toastWidget);
      case GlassToastPosition.bottom:
        return Container(
          margin: EdgeInsets.only(bottom: config.edgeMargin),
          child: Center(child: toastWidget),
        );
    }
  }
}
