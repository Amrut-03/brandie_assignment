import 'dart:ui';

import 'package:brandie_assignment/core/constants/app_assets.dart';
import 'package:brandie_assignment/core/theme/app_colors.dart';
import 'package:brandie_assignment/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog extends StatelessWidget {
  final String title;
  final double progress;

  const LoadingDialog({
    super.key,
    required this.title,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 300.w,
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 28.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppAssets.oriflame_icon,
                width: 52.w,
                height: 52.w,
              ),
              SizedBox(height: 18.h),
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.greyText
                )
              ),
              SizedBox(height: 18.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  minHeight: 7.h,
                  value: progress,
                  backgroundColor: AppColors.lightText,
                  valueColor: const AlwaysStoppedAnimation(
                    AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}