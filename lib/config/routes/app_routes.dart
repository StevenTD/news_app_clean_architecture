import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/article_datail/article_detail.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/saved_article/saved_article.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  if (settings.name == '/ArticleDetails') {
    final article = settings.arguments as ArticleEntity;
    return MaterialPageRoute(
      builder: (context) => ArticleDetailsView(article: article),
    );
  } else if (settings.name == '/SavedArticles') {
    return MaterialPageRoute(builder: (context) => const SavedArticles());
  }
  return null; // Return null for unknown routes
}
