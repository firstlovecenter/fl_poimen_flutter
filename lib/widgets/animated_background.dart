import 'package:flutter/material.dart' hide LinearGradient;
import 'package:flutter/material.dart' as material show LinearGradient;
import 'dart:math' as math;
import 'dart:ui';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;
  final Duration animationDuration;

  const AnimatedBackground({
    Key? key,
    required this.child,
    required this.primaryColor,
    required this.secondaryColor,
    this.animationDuration = const Duration(seconds: 10),
  }) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated Background
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Container(
              decoration: BoxDecoration(
                gradient: material.LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.primaryColor.withOpacity(0.05),
                    widget.secondaryColor.withOpacity(0.1),
                  ],
                  stops: [
                    0.3 + (_controller.value * 0.2),
                    0.7 + (_controller.value * 0.3),
                  ],
                  transform: GradientRotation(_controller.value * 2 * math.pi),
                ),
              ),
            );
          },
        ),

        // Content with backdrop filter for subtle effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: widget.child,
        ),
      ],
    );
  }
}
