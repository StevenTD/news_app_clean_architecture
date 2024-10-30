import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity article;
  final bool isRemovable;
  final void Function(ArticleEntity)? onRemove;
  Function? onArticlePressed;
  ArticleWidget(
      {super.key,
      required this.article,
      required this.isRemovable,
      this.onRemove,
      this.onArticlePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 14),
      height: MediaQuery.of(context).size.width / 2.2,
      child: Row(
        children: [
          _buildImage(context),
          _buildTitleAndDescription(),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    if (isRemovable) {
      return Center(
        child: ElevatedButton(
            onPressed: () => onRemove!(article),
            child: Icon(
              Icons.remove,
              color: Colors.redAccent,
            )),
      );
    }

    return Container();
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article.urlToImage!,
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgres) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            child: const CupertinoActivityIndicator(),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.08)),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            child: const Icon(Icons.refresh),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.08)),
          ),
        ),
      ),
    );
  }

  _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article!.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.black87),
            ),

            // Description
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                article!.description! ?? '',
                maxLines: 2,
              ),
            )),

            // Date Time
            Row(
              children: [
                const Icon(
                  Icons.timeline_outlined,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  article!.publishedAt!,
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
