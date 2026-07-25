import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasource/feed_local_datasource_impl.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedLocalDataSource localDataSource;

  FeedRepositoryImpl(this.localDataSource);

  @override
  Future<List<PostEntity>> getPosts() {
    return localDataSource.getPosts();
  }
}