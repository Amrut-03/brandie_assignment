import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit(this.getPostsUseCase) : super(const FeedState());

  final GetPostsUseCase getPostsUseCase;

  late List<PostEntity> posts;

  static const List<String> loadingStates = [
    "Preparing popular\ncontent for you",
    "Crafting a caption\nto boost engagement",
    "Adding your personal\nreferral link and code",
    "Finding trending songs\non other social media",
  ];

  Future<void> loadPosts() async {
    posts = await getPostsUseCase();

    emit(
      state.copyWith(
        postsLoaded: true,
      ),
    );
  }

  Future<void> startLoading(int totalSteps) async {
    for (int i = 0; i < totalSteps; i++) {
      emit(state.copyWith(
        currentStep: i,
        isCompleted: false,
      ));

      await Future.delayed(const Duration(milliseconds: 800));
    }

    emit(state.copyWith(isCompleted: true));

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(showFeed: true));
  }

  void changePage(int page) {
    emit(state.copyWith(currentPage: page));
  }
}