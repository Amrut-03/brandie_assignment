import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoadingState extends StatefulWidget {
  final String loadingStateName;
  final bool completed;
  final bool loading;

  const LoadingState({
    super.key,
    required this.loadingStateName,
    required this.completed,
    required this.loading,
  });

  @override
  State<LoadingState> createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.w,
      child: Row(
        children: [
          if (widget.completed)
            SvgPicture.asset(
              AppAssets.check,
              width: 20.w,
              height: 20.w,
            )
          else if (widget.loading)
            FadeTransition(
              opacity: Tween(
                begin: .3,
                end: 1.0,
              ).animate(_controller),
              child: SizedBox(
                width: 18.w,
                height: 18.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  color: AppColors.primary,
                ),
              ),
            )
          else
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.lightText,
                ),
              ),
            ),
          SizedBox(width: 15.w),
          FadeTransition(
            opacity: widget.loading
                ? Tween(begin: .5, end: 1.0).animate(_controller)
                : const AlwaysStoppedAnimation(1),
            child: Text(
              widget.loadingStateName,
              style: AppTextStyles.bodyMedium.copyWith(
                color: widget.completed
                    ? AppColors.darkText
                    : const Color(0xFF656B76),
              ),
            ),
          ),
        ],
      ),
    );
  }
}