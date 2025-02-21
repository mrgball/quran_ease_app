import 'package:flutter/material.dart';
import 'package:quran_ease/core/config/extension.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  const ShimmerWidget.rectangle({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  const ShimmerWidget.rounded({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  const ShimmerWidget.circle({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.shape = BoxShape.circle,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.greyText.withOpacity(0.4),
      highlightColor: context.grey.withOpacity(0.2),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.grey.withOpacity(0.4),
          shape: shape,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
