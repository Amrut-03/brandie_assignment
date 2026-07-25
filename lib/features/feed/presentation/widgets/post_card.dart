import 'package:brandie_assignment/features/feed/presentation/widgets/quick_share_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/post_model.dart';
import '../../domain/entities/post_entity.dart';
import 'expandable_caption.dart';
import 'loading_pop_up.dart';

class PostCard extends StatefulWidget {
  final PostEntity data;
  final bool isFirstPost;

  const PostCard({super.key, required this.data, required this.isFirstPost});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool showProductCard = true;
  bool removeProductCard = false;

  @override
  void initState() {
    super.initState();

    if (widget.isFirstPost) {
      _hideCard();
    } else {
      removeProductCard = true;
    }
  }

  Future<void> _hideCard() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() {
      showProductCard = false;
    });

    await Future.delayed(const Duration(milliseconds: 1800));

    if (!mounted) return;

    setState(() {
      removeProductCard = true;
    });
  }

  Future<void> _showLoadingDialogs(BuildContext context) async {
    final steps = [
      ("Generating your sales link...", 0.25),
      ("Copying the caption to clipboard", 0.50),
      ("Saving the content to your profile", 0.75),
      ("Preparing the content for social media", 1.0),
    ];

    for (final step in steps) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(
          title: step.$1,
          progress: step.$2,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 900));

      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(widget.data.post, fit: BoxFit.cover),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 260.h,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),
        ),
        Positioned(
          left: 12.w,
          right: 12.w,
          bottom: 90.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!removeProductCard)
                AnimatedOpacity(
                  opacity: showProductCard ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.easeInOut,
                  child: Container(
                    height: 55.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.greyText.withOpacity(.6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.h),
                      child: Row(
                        children: [
                          Image.asset(AppAssets.lipstickPic),
                          SizedBox(width: 3.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Girodani Gold Lipstick",
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.lightText,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$14.99",
                                    style: AppTextStyles.bodyMediumBold.copyWith(
                                      color: AppColors.lightText,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Container(
                                    height: 17.h,
                                    width: 45.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: const Color(0xFF00725B),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "30% off",
                                        style: AppTextStyles.labelBold.copyWith(
                                          color: AppColors.lightText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 5.h),
              ExpandableCaption(
                key: ValueKey(widget.data.post),
                baseStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.lightText, height: 1.4.h),
                referalCodeText: widget.data.referralCode,
                children: widget.data.caption.map((item) {
                  return TextSpan(
                    text: item.text,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.lightText,
                      fontWeight:
                      item.isBold ? FontWeight.w700 : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 15.h,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text("Quick share to:", style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightText)),
                    SizedBox(width: 8.w),
                    QuickShareIcon(appIcon: AppAssets.instagram, onTap: ()async{
                      await _showLoadingDialogs(context);
                    },),
                    SizedBox(width: 16.w),
                    QuickShareIcon(appIcon: AppAssets.instagram, ringColor: const [Color(0xFFFF64EE),Color(0xFFFF64EE)],onTap: ()async{
                      await _showLoadingDialogs(context);
                    },),
                    SizedBox(width: 16.w),
                    QuickShareIcon(appIcon: AppAssets.facebook, onTap: ()async{
                      await _showLoadingDialogs(context);
                    },),
                    SizedBox(width: 16.w),
                    QuickShareIcon(appIcon: AppAssets.facebook, ringColor: const [Color(0xFF75A5FF),Color(0xFF75A5FF)],onTap: ()async{
                      await _showLoadingDialogs(context);
                    },),
                    SizedBox(width: 16.w),
                    QuickShareIcon(appIcon: AppAssets.facebook_messenger),
                    SizedBox(width: 16.w),
                    QuickShareIcon(appIcon: AppAssets.tiktok),
                    const SizedBox(width: 8),
                    QuickShareIcon(appIcon: AppAssets.whatsapp),
                    const SizedBox(width: 8),
                    QuickShareIcon(appIcon: AppAssets.businessWhatsapp),
                    const SizedBox(width: 8),
                    QuickShareIcon(appIcon: AppAssets.telegram),
                    const SizedBox(width: 8),
                    QuickShareIcon(appIcon: AppAssets.mail),
                    const SizedBox(width: 8),
                    QuickShareIcon(appIcon: AppAssets.oriflame),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Dot extends StatelessWidget {
  final bool active;
  const Dot({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.w,
      height: 10.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppColors.primary : AppColors.lightText,
      ),
    );
  }
}