import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class QuickShareIcon extends StatelessWidget {
  final String appIcon;
  final List<Color>? ringColor;
  final VoidCallback? onTap;

  const QuickShareIcon({
    super.key,
    required this.appIcon,
    this.onTap,
    this.ringColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        padding: ringColor != null ? const EdgeInsets.all(2.5) : EdgeInsets.zero,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: ringColor != null
              ? LinearGradient(
            colors: ringColor!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greyText.withOpacity(.5),
          ),
          child: Padding(
            padding: EdgeInsets.all(ringColor != null ? 4 : 6),
            child: Image.asset(appIcon),
          ),
        ),
      ),
    );
  }
}