# Glass Toast

A beautiful glassmorphism-style toast notification for Flutter.

[![pub package](https://img.shields.io/pub/v/glass_toast.svg)](https://pub.dev/packages/glass_toast)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<p align="center">
  <img src="https://raw.githubusercontent.com/isanghyeog/glass_toast/main/screenshots/demo.gif" width="300" alt="Glass Toast Demo">
</p>

## Features

- Glassmorphism design with backdrop blur effect
- Smooth slide and fade animations
- Preset styles: `info`, `success`, `warning`, `error`
- Customizable position (top, center, bottom)
- Light and dark theme support
- Fully customizable appearance
- Tap to dismiss
- Only one toast at a time (auto-removes previous)

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  glass_toast: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:glass_toast/glass_toast.dart';

// Info toast
GlassToast.info(context, 'This is an info message');

// Success toast
GlassToast.success(context, 'Operation completed!');

// Warning toast
GlassToast.warning(context, 'Please check your input');

// Error toast
GlassToast.error(context, 'Something went wrong');
```

### Custom Toast

```dart
GlassToast.show(
  context,
  message: 'Custom message',
  icon: Icons.star,
  iconColor: Colors.amber,
  duration: const Duration(seconds: 3),
  position: GlassToastPosition.bottom,
);
```

### Position

```dart
// Top (default)
GlassToast.info(context, 'Top toast', position: GlassToastPosition.top);

// Center
GlassToast.info(context, 'Center toast', position: GlassToastPosition.center);

// Bottom
GlassToast.info(context, 'Bottom toast', position: GlassToastPosition.bottom);
```

### Dark Theme

```dart
// Use dark config for a single toast
GlassToast.info(
  context,
  'Dark mode toast',
  config: GlassToastConfig.dark,
);

// Or set as default for all toasts
GlassToast.setDefaultConfig(GlassToastConfig.dark);
```

### Custom Configuration

```dart
final customConfig = GlassToastConfig(
  backgroundColors: [
    Colors.purple.withOpacity(0.85),
    Colors.purple.withOpacity(0.75),
  ],
  borderColor: Colors.purpleAccent.withOpacity(0.5),
  textColor: Colors.white,
  borderRadius: 24.0,
  blurSigma: 30.0,
  maxWidth: 500.0,
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  edgeMargin: 100.0,
  animationDuration: const Duration(milliseconds: 400),
  animationCurve: Curves.elasticOut,
);

GlassToast.info(context, 'Custom styled toast', config: customConfig);
```

### Dismiss Programmatically

```dart
GlassToast.dismiss();
```

## Configuration Options

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `backgroundColors` | `List<Color>` | White gradient | Gradient colors for background |
| `borderColor` | `Color` | White 50% | Border color |
| `textColor` | `Color` | Gray 800 | Text color |
| `shadowColor` | `Color` | Black 10% | Shadow color |
| `borderRadius` | `double` | 16.0 | Corner radius |
| `blurSigma` | `double` | 20.0 | Blur intensity |
| `maxWidth` | `double` | 400.0 | Maximum width |
| `padding` | `EdgeInsets` | H:20, V:14 | Inner padding |
| `edgeMargin` | `double` | 80.0 | Distance from screen edge |
| `animationDuration` | `Duration` | 300ms | Animation duration |
| `animationCurve` | `Curve` | easeOutCubic | Animation curve |
| `defaultIconColor` | `Color` | Gray 500 | Default icon color |
| `textStyle` | `TextStyle?` | null | Custom text style |

## License

MIT License - see [LICENSE](LICENSE) for details.
