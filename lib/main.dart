import 'package:flutter/material.dart';

void main() {
  runApp(const SkyperkyApp());
}

/// Root widget for the Skypersky application.
class SkyperkyApp extends StatelessWidget {
  /// Creates the Skypersky application.
  const SkyperkyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skypersky',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'OpenSans'),
      ),
      home: const ProtectionScreen(),
    );
  }
}

/// Main screen displaying the protection toggle.
class ProtectionScreen extends StatefulWidget {
  /// Creates the protection screen.
  const ProtectionScreen({super.key});

  @override
  State<ProtectionScreen> createState() => _ProtectionScreenState();
}

class _ProtectionScreenState extends State<ProtectionScreen> {
  bool _isProtectionEnabled = false;

  void _toggleProtection({required bool value}) {
    setState(() {
      _isProtectionEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C3C3C),
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/skypersky-C2N3t0p9.png'),
        ),
        centerTitle: true,
        title: const Text(
          'Skypersky',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2D5649),
              Color(0xFF26413B),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Shield watermark anchored to left edge, half hidden
            Positioned(
              left: -100,
              top: 0,
              bottom: 0,
              child: Center(
                child: Opacity(
                  opacity: 0.08,
                  child: Image.asset(
                    'assets/shield-BfBTlFgy.png',
                    height: 300,
                  ),
                ),
              ),
            ),
            // Main content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Protection',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _ProtectionSwitch(
                    isActive: _isProtectionEnabled,
                    onChanged: (value) =>
                        _toggleProtection(value: value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom toggle switch with a shield status icon in the track background.
///
/// When off, the thumb is on the left and a gray shield sits in the right
/// side of the track. When on, the thumb is on the right and a green
/// checkmark shield sits in the left side of the track.
class _ProtectionSwitch extends StatelessWidget {
  const _ProtectionSwitch({
    required this.isActive,
    required this.onChanged,
  });

  final bool isActive;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isActive),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 72,
        height: 38,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          color: isActive ? Colors.green : Colors.grey.shade300,
        ),
        child: Stack(
          children: [
            // Shield icon in the track background, opposite side of thumb
            Align(
              alignment:
                  isActive ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  isActive
                      ? Icons.verified_user
                      : Icons.gpp_maybe,
                  color: isActive
                      ? Colors.white
                      : Colors.grey.shade400,
                  size: 20,
                ),
              ),
            ),
            // Sliding thumb
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment:
                  isActive ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
