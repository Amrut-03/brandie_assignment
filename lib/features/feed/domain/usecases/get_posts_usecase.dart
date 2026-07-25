import '../entities/post_entity.dart';
import '../repositories/feed_repository.dart';

class GetPostsUseCase {
  final FeedRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<PostEntity>> call() {
    return repository.getPosts();
  }
}