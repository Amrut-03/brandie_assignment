
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle satoshiBold = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
  );

  static TextStyle heading = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle bodyMediumBold = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle label = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle labelBold = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
  );
}