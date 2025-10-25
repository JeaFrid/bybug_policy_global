import 'package:flutter/material.dart';

class Pressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final Duration duration;
  const Pressable({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.94,
    this.duration = const Duration(milliseconds: 120),
  });

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  double _currentScale = 1.0;

  void _animate(bool down) {
    setState(() => _currentScale = down ? widget.scale : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animate(true),
      onTapUp: (_) {
        _animate(false);
        Future.delayed(widget.duration, () {
          if (widget.onTap != null) widget.onTap!();
        });
      },
      onTapCancel: () => _animate(false),
      child: AnimatedScale(
        scale: _currentScale,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
