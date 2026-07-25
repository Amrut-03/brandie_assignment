import 'package:brandie_assignment/core/constants/app_assets.dart';
import 'package:brandie_assignment/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../screens/edit_caption_screen.dart';

class ExpandableCaption extends StatefulWidget {
  final List<InlineSpan> children;
  final TextStyle baseStyle;
  final int collapsedMaxLines;
  final Color seeMoreColor;
  final String referalCodeText;

  const ExpandableCaption({
    super.key,
    required this.children,
    required this.baseStyle,
    this.collapsedMaxLines = 2,
    this.seeMoreColor = AppColors.lightText,
    required this.referalCodeText,
  });

  @override
  State<ExpandableCaption> createState() => _ExpandableCaptionState();
}

class _ExpandableCaptionState extends State<ExpandableCaption> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fullSpan = TextSpan(style: widget.baseStyle, children: widget.children);

        final painter = TextPainter(
          text: fullSpan,
          maxLines: widget.collapsedMaxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = painter.didExceedMaxLines;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.transparentBg.withOpacity(.5),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!_expanded) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.aiCaption),
                          SizedBox(width: 5.w),
                          Text(
                            "Caption Suggestion".toUpperCase(),
                            style: AppTextStyles.labelBold.copyWith(
                              color: AppColors.lightText,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditCaptionScreen(
                                caption: widget.children
                                    .map((e) => (e as TextSpan).text ?? "")
                                    .join(),
                                referralText: widget.referalCodeText,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(AppAssets.pencil),
                            SizedBox(width: 4.w),
                            Text(
                              "Edit Caption",
                              style: AppTextStyles.bodyMediumBold.copyWith(
                                color: AppColors.lightText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
                _expanded || !isOverflowing
                    ? GestureDetector(
                  onTap: isOverflowing ? () => setState(() => _expanded = !_expanded) : null,
                  behavior: HitTestBehavior.opaque,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: widget.baseStyle,
                      children: [
                        ...widget.children,
                        if (isOverflowing)
                          TextSpan(
                            text: "  see less",
                            style: widget.baseStyle.copyWith(
                              color: widget.seeMoreColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                )
                    : _buildCollapsedText(constraints),
                SizedBox(height: 10.h),
                Text(
                  widget.referalCodeText,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12.sp,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCollapsedText(BoxConstraints constraints) {
    final seeMoreSpan = TextSpan(
      text: "... see more",
      style: widget.baseStyle.copyWith(
        color: widget.seeMoreColor,
        fontWeight: FontWeight.w700,
      ),
    );

    final fullText = widget.children.map((s) => (s as TextSpan).text ?? '').join();

    final endIndex = _findCutoffIndex(
      fullText: fullText,
      style: widget.baseStyle,
      maxWidth: constraints.maxWidth,
      maxLines: widget.collapsedMaxLines,
      seeMoreWidth: (TextPainter(
        text: seeMoreSpan,
        textDirection: TextDirection.ltr,
      )..layout()).width,
    );

    final truncatedText = fullText.substring(0, endIndex).trimRight();

    return GestureDetector(
      onTap: () => setState(() => _expanded = true),
      behavior: HitTestBehavior.opaque,
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: widget.baseStyle,
          children: [
            TextSpan(text: truncatedText),
            seeMoreSpan,
          ],
        ),
      ),
    );
  }

  int _findCutoffIndex({
    required String fullText,
    required TextStyle style,
    required double maxWidth,
    required int maxLines,
    required double seeMoreWidth,
  }) {
    int low = 0;
    int high = fullText.length;
    int best = 0;

    while (low <= high) {
      final mid = (low + high) ~/ 2;
      final testPainter = TextPainter(
        text: TextSpan(text: fullText.substring(0, mid), style: style),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxWidth);

      if (!testPainter.didExceedMaxLines) {
        best = mid;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    return best;
  }
}