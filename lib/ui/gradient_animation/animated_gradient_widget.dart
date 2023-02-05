import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'gradient_container.dart';

class AnimatedGradientWidget extends StatefulWidget {
  final Widget widget;
  final Color firstColor;
  final Color secondColor;
  const AnimatedGradientWidget({
    Key? key,
    required this.widget,
    required this.firstColor,
    required this.secondColor,
  }) : super(key: key);

  @override
  State<AnimatedGradientWidget> createState() => _AnimatedGradientWidgetState();
}

class _AnimatedGradientWidgetState extends State<AnimatedGradientWidget> with SingleTickerProviderStateMixin {
  late AnimationController colorController;

  late Animation<Color?> color1;
  late Animation<Color?> color2;
  late Animation<Color?> color3;
  late Animation<Color?> color4;

  @override
  void initState() {
    colorController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    color1 = ColorTween(begin: widget.firstColor, end: widget.secondColor).animate(colorController)..addListener(() => setState(() {}));
    color2 = ColorTween(begin: widget.secondColor, end: widget.firstColor.withOpacity(0.5)).animate(colorController)..addListener(() => setState(() {}));
    color3 = ColorTween(begin: widget.firstColor.withOpacity(0.5), end: widget.secondColor).animate(colorController)..addListener(() => setState(() {}));
    color4 = ColorTween(begin: widget.secondColor, end: widget.firstColor).animate(colorController)..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorController,
      builder: ((context, child) {
        return Transform(
          transform: Matrix4.rotationY((colorController.value) * math.pi / 10),
          alignment: Alignment.center,
          child: GradientContainer(
            gradient: LinearGradient(
              begin: const Alignment(-4, 4),
              end: const Alignment(4, -4),
              colors: [
                color1.value!,
                color2.value!,
                color3.value!,
                color4.value!,
              ],
            ),
            child: widget.widget,
          ),
        );
      }),
    );
  }
}