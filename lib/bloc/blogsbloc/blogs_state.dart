import 'package:blog_explorer/models/article_model.dart';
import 'package:equatable/equatable.dart';



class BlogsStates extends Equatable {
  const BlogsStates();

  @override
  List<Object> get props => [];
}

class BlogsInitState extends BlogsStates {}

class BlogsLoadingState extends BlogsStates {}

class BlogsLoadedState extends BlogsStates {
  final List<ArticleModel> articleList;
  BlogsLoadedState({required this.articleList});
  
}

class BlogsErrorState extends BlogsStates {
  final String errorMessage;
  BlogsErrorState({required this.errorMessage});
}