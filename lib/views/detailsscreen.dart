import 'package:blog_explorer/models/article_model.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String tag;
  final ArticleModel article;
  const DetailsScreen({Key? key, required this.article, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                        tag: '${article.title}',
                        child: Image.network(article.imageUrl ?? '')),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Text(
                            '${article.title}',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                         
                          SizedBox(
                            height: 20.0,
                          ),
                          
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ))
            ],
          )),
    );
  }
}