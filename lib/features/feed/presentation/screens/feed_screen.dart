import 'package:brandie_assignment/core/constants/app_assets.dart';
import 'package:brandie_assignment/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/feed_cubit.dart';
import '../cubit/feed_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/expandable_title_text.dart';
import '../widgets/loading_state.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cubit = context.read<FeedCubit>();

      await cubit.loadPosts();

      await cubit.startLoading(
        FeedCubit.loadingStates.length,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<FeedCubit, FeedState>(
          builder: (context, state){
            if (!state.postsLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final posts = context.read<FeedCubit>().posts;

            return SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: const CustomAppBar(),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Smart Post", style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary)),
                        Text("Library", style: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkText)),
                        Text("Communities", style: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkText)),
                        Text("Share&Win", style: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkText)),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if(!state.showFeed)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 60.h,),
                        Text(
                          "Building personalised \nSmart Posts for you!",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading.copyWith(
                            color: AppColors.darkText,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: FeedCubit.loadingStates.length,
                          itemBuilder: (context, index) {
                            final bool completed = index < state.currentStep;
                            final bool loading = index == state.currentStep && !state.isCompleted;

                            return Padding(
                              padding: EdgeInsets.only(bottom: 25.h),
                              child: Center(
                                child: LoadingState(
                                  loadingStateName: FeedCubit.loadingStates[index],
                                  completed: completed,
                                  loading: loading,
                                ),
                              ),
                            );
                          },
                        ),
                        AnimatedOpacity(
                          opacity: state.isCompleted ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: Text(
                              "All set! Get ready to share...",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: const Color(0xFF54565F),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  if(state.showFeed)
                    Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              PageView.builder(
                                controller: _pageController,
                                scrollDirection: Axis.vertical,
                                itemCount: posts.length,
                                onPageChanged: (index) {
                                  context.read<FeedCubit>().changePage(index);
                                },
                                itemBuilder: (context, index) {
                                  return PostCard(
                                    data: posts[index],
                                    isFirstPost: index == 0,
                                  );
                                },
                              ),

                              /// Top User Info
                              Positioned(
                                top: 16.h,
                                left: 12.w,
                                right: 12.w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 22.r,
                                      backgroundImage: AssetImage(AppAssets.profilePic),
                                    ),
                                    SizedBox(width: 8.w),
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color(0xFFFF6F91),
                                                  Color(0xFFB388EB),
                                                ],
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.asset(AppAssets.stars),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  "Ready to share",
                                                  style: AppTextStyles.satoshiBold.copyWith(
                                                    color: AppColors.lightText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 3.h),
                                          ExpandableTitleText(
                                            text: "High-converting in Oriflame Community",
                                            style: AppTextStyles.bodyMediumBold.copyWith(
                                              color: AppColors.lightText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.transparentBg.withOpacity(.5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 250),
                                        child: Text(
                                          "${state.currentPage + 1} of ${posts.length}",
                                          key: ValueKey<int>(state.currentPage),
                                          style: AppTextStyles.bodySmall.copyWith(
                                            color: AppColors.lightText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// Page Indicator
                              Positioned(
                                top: MediaQuery.of(context).size.height / 2 - 150.h,
                                right: 12.w,
                                child: Container(
                                  width: 22.w,
                                  padding: EdgeInsets.symmetric(vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.transparentBg.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(posts.length, (i) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(vertical: 4.h),
                                        child: AnimatedOpacity(
                                          duration: const Duration(milliseconds: 250),
                                          opacity: i == state.currentPage ? 1.0 : 0.4,
                                          child: Dot(active: i == state.currentPage),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),

                              /// Bottom Navigation
                              Positioned(
                                left: 12.w,
                                right: 12.w,
                                bottom: 20.h,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 10.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(AppAssets.rocket),
                                      SvgPicture.asset(AppAssets.search),
                                      SvgPicture.asset(AppAssets.home),
                                      SvgPicture.asset(AppAssets.comment),
                                      SvgPicture.asset(AppAssets.profile),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    )
                ],
              ),
            );
          })
    );
  }
}