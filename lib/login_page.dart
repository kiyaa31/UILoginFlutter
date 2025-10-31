import 'dart:math';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color purple = const Color(0xFF9C27B0);
    final Color pink = const Color(0xFFFF80AB);

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            children: [
              // Background wave animation
              CustomPaint(
                size: MediaQuery.of(context).size,
                painter: SilkWavePainter(_controller.value),
              ),
              // Subtle white shimmer
              Opacity(
                opacity: 0.35,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.0),
                        Colors.white.withOpacity(0.7),
                        Colors.white.withOpacity(0.0),
                      ],
                      begin: Alignment(-1.2 + _controller.value * 2.4, -0.3),
                      end: Alignment(1.2 - _controller.value * 2.4, 0.3),
                    ),
                  ),
                ),
              ),
              // Main login card
              Center(
                child: Container(
                  width: 340,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white, // card putih solid
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: purple.withOpacity(0.4),
                        blurRadius: 40,
                        spreadRadius: 6,
                        offset: const Offset(0, 12),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFFFF80AB), Color(0xFFBA68C8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: const Icon(
                          Icons.person_rounded,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 25),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(color: purple.withOpacity(0.8)),
                          prefixIcon: Icon(Icons.person_outline, color: purple.withOpacity(0.9)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: purple.withOpacity(0.3), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: purple.withOpacity(0.8), width: 1.8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: purple.withOpacity(0.8)),
                          prefixIcon: Icon(Icons.lock_outline, color: purple.withOpacity(0.9)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: purple.withOpacity(0.3), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: purple.withOpacity(0.8), width: 1.8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: purple.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFAB47BC), Color(0xFFFF80AB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: purple.withOpacity(0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SilkWavePainter extends CustomPainter {
  final double progress;
  SilkWavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final gradient = LinearGradient(
      colors: [
        const Color(0xFFFF80AB).withOpacity(0.7),
        const Color(0xFFBA68C8).withOpacity(0.7),
        const Color(0xFFF3E5F5).withOpacity(0.5),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    paint.shader = gradient;

    const double waveHeight = 55;
    final double speed = progress * 2 * pi;

    final path = Path();
    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x++) {
      double y = sin((x / size.width * 2 * pi) + speed) * waveHeight + (size.height / 2);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // background lembut
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFFAF0F8).withOpacity(0.15),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SilkWavePainter oldDelegate) => oldDelegate.progress != progress;
}