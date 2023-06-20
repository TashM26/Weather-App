import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/ui/theme/app_colors.dart';

class BlurContainer extends StatelessWidget {
  final Widget? child;
  const BlurContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 9,
          sigmaY: 9,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.blurContainer,
            borderRadius: BorderRadius.circular(5),
          ),
          child: child,
        ),
      ),
    );
  }
}
