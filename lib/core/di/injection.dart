import 'package:get_it/get_it.dart';

import '../../features/feed/data/datasource/feed_local_datasource_impl.dart';
import '../../features/feed/data/repositories/feed_repositroy_impl.dart';
import '../../features/feed/domain/repositories/feed_repository.dart';
import '../../features/feed/domain/usecases/get_posts_usecase.dart';
import '../../features/feed/presentation/cubit/feed_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(() => FeedCubit(sl()));

  sl.registerLazySingleton(
        () => GetPostsUseCase(sl()),
  );

  sl.registerLazySingleton<FeedRepository>(
        () => FeedRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<FeedLocalDataSource>(
        () => FeedLocalDataSourceImpl(),
  );
}