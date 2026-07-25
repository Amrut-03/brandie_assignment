import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class EditCaptionScreen extends StatefulWidget {
  final String caption;
  final String referralText;

  const EditCaptionScreen({
    super.key,
    required this.caption,
    required this.referralText,
  });

  @override
  State<EditCaptionScreen> createState() => _EditCaptionScreenState();
}

class _EditCaptionScreenState extends State<EditCaptionScreen> {
  late TextEditingController controller;
  bool hasChanges = false;
  late String originalText;

  @override
  void initState() {
    super.initState();

    originalText =
    "${widget.caption}\n\n${widget.referralText}";

    controller = TextEditingController(
      text: originalText,
    );

    controller.addListener(() {
      final changed = controller.text != originalText;

      if (changed != hasChanges) {
        setState(() {
          hasChanges = changed;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Edit Caption",
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkText,
            fontSize: 20.sp,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: SizedBox(
              height: 30.h,
              child: ElevatedButton(
                onPressed: hasChanges
                    ? () {
                  Navigator.pop(
                    context,
                    controller.text,
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasChanges
                      ? const Color(0xFF7EC086)
                      : const Color(0xFF7EC086).withOpacity(0.3),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF7EC086).withOpacity(0.3),
                  disabledForegroundColor: Colors.white70,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: TextField(
          controller: controller,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.darkText,
            height: 1.6.h,
          ),
        ),
      ),
    );
  }
}