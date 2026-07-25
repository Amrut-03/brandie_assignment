import 'package:brandie_assignment/core/constants/app_assets.dart';
import 'package:brandie_assignment/core/theme/app_colors.dart';
import 'package:brandie_assignment/core/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Image.asset(AppAssets.aiAssistant),
            SizedBox(height: 5.h,),
            Text("Your Assistant", style: AppTextStyles.label.copyWith(color: AppColors.greyText),),
          ],
        ),
        Image.asset(AppAssets.appName),
        Column(
          children: [
            Container(
              height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                  color: AppColors.lightDarkBg,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.h),
                  child: SvgPicture.asset(AppAssets.camera),
                )
            ),
            SizedBox(height: 5.h,),
            Text("Camera",
              style: AppTextStyles.label.copyWith(
                  color: AppColors.greyText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
