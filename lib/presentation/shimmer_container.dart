import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  const ShimmerContainer({Key? key, required this.child, this.baseColor, this.highlightColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade500,
      highlightColor: highlightColor ?? Colors.white,
      child: child,
    );
  }
}
