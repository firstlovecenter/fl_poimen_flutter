import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poimen/theme.dart';
import 'package:rive/rive.dart';
import 'package:shimmer/shimmer.dart';

/// Loading animation style options
enum LoadingStyle {
  /// Classic circular spinner
  circular,

  /// Pulsating dot animation
  pulse,

  /// Bouncing dots animation
  bounce,

  /// Rotating dots animation
  orbit,

  /// A shimmering effect
  shimmer,

  /// Uses the project's Rive animation
  rive,
}

/// An enhanced loading indicator widget with multiple animation styles
class LoadingIndicator extends StatefulWidget {
  /// The size of the loading indicator
  final double size;

  /// The stroke width for applicable indicators
  final double strokeWidth;

  /// Primary color for the animation
  final Color color;

  /// Secondary color for animations that support multiple colors
  final Color? secondaryColor;

  /// Background color for the indicator
  final Color? backgroundColor;

  /// The style of animation to display
  final LoadingStyle style;

  /// Optional text to display below the loader
  final String? loadingText;

  /// Text style for the loading text
  final TextStyle? textStyle;

  /// Number of dots for dot-based animations
  final int dotCount;

  LoadingIndicator({
    Key? key,
    this.size = 40.0,
    this.strokeWidth = 4.0,
    Color? color,
    this.secondaryColor,
    this.backgroundColor,
    this.style = LoadingStyle.circular,
    this.loadingText,
    this.textStyle,
    this.dotCount = 3,
  })  : color = color ?? PoimenTheme.brand,
        super(key: key);

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: _buildLoadingIndicator(),
        ),
        if (widget.loadingText != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.loadingText!,
            style: widget.textStyle ??
                TextStyle(
                  color: widget.color,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    switch (widget.style) {
      case LoadingStyle.circular:
        return _buildCircularIndicator();
      case LoadingStyle.pulse:
        return _buildPulseIndicator();
      case LoadingStyle.bounce:
        return _buildBouncingDotsIndicator();
      case LoadingStyle.orbit:
        return _buildOrbitIndicator();
      case LoadingStyle.shimmer:
        return _buildShimmerIndicator();
      case LoadingStyle.rive:
        return _buildRiveAnimation();
    }
  }

  Widget _buildCircularIndicator() {
    return CircularProgressIndicator(
      strokeWidth: widget.strokeWidth,
      valueColor: AlwaysStoppedAnimation<Color>(widget.color),
      backgroundColor: widget.backgroundColor,
    );
  }

  Widget _buildPulseIndicator() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.size * (0.6 + 0.4 * _controller.value),
          height: widget.size * (0.6 + 0.4 * _controller.value),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withOpacity(0.4 - 0.3 * _controller.value),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.3 - 0.2 * _controller.value),
                blurRadius: widget.size * 0.3,
                spreadRadius: widget.size * 0.1 * _controller.value,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: widget.size * 0.5,
              height: widget.size * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBouncingDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.dotCount, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double bounce =
                sin((_controller.value * pi) + (index * (pi / widget.dotCount * 2)));
            return Container(
              margin: EdgeInsets.symmetric(horizontal: widget.size * 0.05),
              width: widget.size * 0.2,
              height: widget.size * 0.2,
              child: Transform.translate(
                offset: Offset(0, -bounce * widget.size * 0.3),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.secondaryColor != null
                        ? Color.lerp(
                            widget.color, widget.secondaryColor!, index / (widget.dotCount - 1))
                        : widget.color,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildOrbitIndicator() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Center dot
            Container(
              width: widget.size * 0.2,
              height: widget.size * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
            ),
            // Orbiting dots
            ...List.generate(widget.dotCount, (index) {
              final double angle =
                  (_controller.value * 2 * pi) + (index * (2 * pi / widget.dotCount));
              final double x = cos(angle) * (widget.size * 0.35);
              final double y = sin(angle) * (widget.size * 0.35);

              return Transform.translate(
                offset: Offset(x, y),
                child: Container(
                  width: widget.size * 0.15,
                  height: widget.size * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.secondaryColor != null
                        ? Color.lerp(
                            widget.color, widget.secondaryColor!, index / (widget.dotCount - 1))
                        : widget.color.withOpacity(0.7),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildShimmerIndicator() {
    return Shimmer.fromColors(
      baseColor: widget.color.withOpacity(0.4),
      highlightColor: widget.secondaryColor ?? widget.color,
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiveAnimation() {
    return Container(
      width: widget.size,
      height: widget.size,
      alignment: Alignment.center,
      child: const RiveAnimation.asset(
        'assets/animations/loader.riv',
        fit: BoxFit.contain,
      ),
    );
  }
}
