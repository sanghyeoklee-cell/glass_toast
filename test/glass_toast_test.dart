import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_toast/glass_toast.dart';

void main() {
  group('GlassToastConfig', () {
    test('light config has correct default values', () {
      const config = GlassToastConfig.light;
      expect(config.borderRadius, 16.0);
      expect(config.blurSigma, 20.0);
      expect(config.maxWidth, 400.0);
    });

    test('dark config has dark colors', () {
      const config = GlassToastConfig.dark;
      expect(config.textColor, const Color(0xFFF9FAFB));
    });

    test('copyWith creates modified config', () {
      const original = GlassToastConfig.light;
      final modified = original.copyWith(borderRadius: 24.0);
      expect(modified.borderRadius, 24.0);
      expect(modified.blurSigma, original.blurSigma);
    });
  });

  group('GlassToastPosition', () {
    test('has all expected values', () {
      expect(GlassToastPosition.values.length, 3);
      expect(GlassToastPosition.values, contains(GlassToastPosition.top));
      expect(GlassToastPosition.values, contains(GlassToastPosition.center));
      expect(GlassToastPosition.values, contains(GlassToastPosition.bottom));
    });
  });

  group('GlassToast', () {
    tearDown(() {
      // Clean up any remaining toast
      GlassToast.dismiss();
    });

    testWidgets('info shows toast with info icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => GlassToast.info(context, 'Test message'),
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();

      expect(find.text('Test message'), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);

      // Dismiss and wait for animation
      GlassToast.dismiss();
      await tester.pump();
    });

    testWidgets('success shows toast with success icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => GlassToast.success(context, 'Success!'),
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();

      expect(find.text('Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);

      GlassToast.dismiss();
      await tester.pump();
    });

    testWidgets('warning shows toast with warning icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => GlassToast.warning(context, 'Warning!'),
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();

      expect(find.text('Warning!'), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);

      GlassToast.dismiss();
      await tester.pump();
    });

    testWidgets('error shows toast with error icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => GlassToast.error(context, 'Error!'),
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();

      expect(find.text('Error!'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      GlassToast.dismiss();
      await tester.pump();
    });

    testWidgets('dismiss removes toast', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => GlassToast.info(context, 'Test'),
                    child: const Text('Show'),
                  ),
                  ElevatedButton(
                    onPressed: () => GlassToast.dismiss(),
                    child: const Text('Dismiss'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      expect(find.text('Test'), findsOneWidget);

      await tester.tap(find.text('Dismiss'));
      await tester.pump();
      expect(find.text('Test'), findsNothing);
    });

    testWidgets('new toast replaces old toast', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => GlassToast.info(context, 'Toast One'),
                    child: const Text('Show First'),
                  ),
                  ElevatedButton(
                    onPressed: () => GlassToast.info(context, 'Toast Two'),
                    child: const Text('Show Second'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show First'));
      await tester.pump();
      expect(find.text('Toast One'), findsOneWidget);

      await tester.tap(find.text('Show Second'));
      await tester.pump();
      expect(find.text('Toast One'), findsNothing);
      expect(find.text('Toast Two'), findsOneWidget);

      GlassToast.dismiss();
      await tester.pump();
    });
  });
}
