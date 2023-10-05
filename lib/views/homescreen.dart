// import 'dart:io';



import 'package:blog_explorer/bloc/blogsbloc/blogs_state.dart';
import 'package:blog_explorer/bloc/blogsbloc/blogsbloc.dart';

import 'package:blog_explorer/models/article_model.dart';
import 'package:blog_explorer/views/detailsscreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Widget listbuilder(
      List<ArticleModel> articleList, double height, double width) {
    return ListView.builder(
      itemCount: articleList.length,
      itemBuilder: (context, index) {
        var article = articleList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  article: article,
                  tag: '',
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 196, 179, 179),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: Color.fromARGB(255, 74, 68, 68),
                  offset: Offset(0, 2),
                  spreadRadius: 1,
                )
              ],
            ),
            height: height * 0.15,
            margin: EdgeInsets.only(
              bottom: height * 0.01,
              top: height * 0.01,
              left: width * 0.02,
              right: width * 0.02,
            ),
            child: Row(
              children: [
                Container(
                  width: width * 0.3,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(article.imageUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Container(
                  height: height * 0.15,
                  width: width * 0.55,
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title ?? '',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle favorite button tap here
                            // Toggle the favorite status and update UI accordingly
                            setState(() {
                              article.isFavorite = !(article.isFavorite!);
                            });
                          },
                          child: Icon(
                            article.isFavorite!
                                ? Icons.favorite_outline
                                : Icons.favorite,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (article.isFavorite!)
                                ? Colors.grey
                                : Colors.red,
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.03),
                  child: Text(
                    "Bloc News".toUpperCase(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.7),
                  width: width,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                )
              ],
            ),
          ),
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: height * 0.08),
              child: BlocBuilder<BlogsBloc, BlogsStates>(
                builder: (context, state) {
                  if (state is BlogsLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is BlogsLoadedState) {
                    List<ArticleModel> articleList = [];
                    articleList = state.articleList;
                    return listbuilder(articleList, height, width);
                  } else if (state is BlogsErrorState) {
                    return Text('Error: ${state.errorMessage}');
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ));
                  }
                },
              ))
        ],
      )),
    );
  }
}
