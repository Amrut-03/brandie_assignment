class FeedState {
  final int currentPage;
  final int currentStep;
  final bool isCompleted;
  final bool showFeed;
  final bool postsLoaded;

  const FeedState({
    this.currentPage = 0,
    this.currentStep = 0,
    this.isCompleted = false,
    this.showFeed = false,
    this.postsLoaded = false,
  });

  FeedState copyWith({
    int? currentPage,
    int? currentStep,
    bool? isCompleted,
    bool? showFeed,
    bool? postsLoaded,
  }) {
    return FeedState(
      currentPage: currentPage ?? this.currentPage,
      currentStep: currentStep ?? this.currentStep,
      isCompleted: isCompleted ?? this.isCompleted,
      showFeed: showFeed ?? this.showFeed,
      postsLoaded: postsLoaded ?? this.postsLoaded
    );
  }
}