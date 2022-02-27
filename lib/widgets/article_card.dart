import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_test_ui/models/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whatsapp_test_ui/screens/article_view.dart';

class ArticleCard extends StatelessWidget {
  final NewsModel newsModel;
  final String url;

  const ArticleCard({required this.newsModel, required this.url});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(5),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ArticleView(blogUrl: url);
            }));
          },
          child: SizedBox(
            height: 300,
            width: screenSize.width,
            child: CachedNetworkImage(
              imageUrl: newsModel.urlToImage!,
              height: 300,
              width: screenSize.width,
              placeholder: (context, url) => Image.asset(
                'assets/images/placeholder.png',
                fit: BoxFit.cover,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 70,
          decoration: const BoxDecoration(color: Colors.black54),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  newsModel.title!,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  newsModel.description!,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  newsModel.publishedAt!,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
