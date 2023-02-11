import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({Key? key, required this.child, required this.gradient}) : super(key: key);
  final Widget child; 
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => gradient.createShader(Rect.fromLTRB(0, 0, bounds.right, bounds.bottom)),
        child: child);
  }
}