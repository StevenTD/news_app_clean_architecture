import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final s1 = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  s1.registerSingleton<AppDatabase>(database);

  // Dio
  s1.registerSingleton<Dio>(Dio());

  // Dependencies
  s1.registerSingleton<NewsApiService>(NewsApiService(s1()));

  s1.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(s1()));

  s1.registerSingleton<GetArticleUseCase>(GetArticleUseCase(s1()));

  // Blocks
  s1.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(s1()));
}
