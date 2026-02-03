import 'package:flutter/material.dart';
import 'package:glass_toast/glass_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass Toast Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkMode = false;
  GlassToastPosition _position = GlassToastPosition.top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glass Toast Example'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() => _isDarkMode = !_isDarkMode);
              GlassToast.setDefaultConfig(
                _isDarkMode ? GlassToastConfig.dark : GlassToastConfig.light,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isDarkMode
                ? [const Color(0xFF1F2937), const Color(0xFF111827)]
                : [const Color(0xFFE0E7FF), const Color(0xFFFCE7F3)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Position selector
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Position',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SegmentedButton<GlassToastPosition>(
                          segments: const [
                            ButtonSegment(
                              value: GlassToastPosition.top,
                              label: Text('Top'),
                            ),
                            ButtonSegment(
                              value: GlassToastPosition.center,
                              label: Text('Center'),
                            ),
                            ButtonSegment(
                              value: GlassToastPosition.bottom,
                              label: Text('Bottom'),
                            ),
                          ],
                          selected: {_position},
                          onSelectionChanged: (selected) {
                            setState(() => _position = selected.first);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Toast buttons
                const Text(
                  'Toast Types',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => GlassToast.info(
                        context,
                        'This is an info message',
                        position: _position,
                      ),
                      icon: const Icon(Icons.info_outline, color: Color(0xFF3B82F6)),
                      label: const Text('Info'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => GlassToast.success(
                        context,
                        'Operation completed successfully!',
                        position: _position,
                      ),
                      icon: const Icon(Icons.check_circle_outline, color: Color(0xFF10B981)),
                      label: const Text('Success'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => GlassToast.warning(
                        context,
                        'Please check your input',
                        position: _position,
                      ),
                      icon: const Icon(Icons.warning_amber_outlined, color: Color(0xFFF59E0B)),
                      label: const Text('Warning'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => GlassToast.error(
                        context,
                        'Something went wrong!',
                        position: _position,
                      ),
                      icon: const Icon(Icons.error_outline, color: Color(0xFFEF4444)),
                      label: const Text('Error'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Custom toast
                ElevatedButton.icon(
                  onPressed: () => GlassToast.show(
                    context,
                    message: 'Custom toast with star icon',
                    icon: Icons.star,
                    iconColor: Colors.amber,
                    position: _position,
                    duration: const Duration(seconds: 3),
                  ),
                  icon: const Icon(Icons.star, color: Colors.amber),
                  label: const Text('Custom Toast'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
