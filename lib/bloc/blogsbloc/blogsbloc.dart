import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_explorer/bloc/blogsbloc/blogs_event.dart';
import 'package:blog_explorer/bloc/blogsbloc/blogs_state.dart';
// import 'package:blog_explorer/cubit/Internet/internet_state.dart';
import 'package:blog_explorer/models/article_model.dart';
import 'package:blog_explorer/repositories/blogs_repository.dart';
import 'package:blog_explorer/services/database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BlogsBloc extends Bloc<BlogsEvents, BlogsStates> {
  BlogsRepo blogsrepo;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  BlogsBloc({required BlogsStates initialState, required this.blogsrepo})
      : super(initialState) {
    on<StartEvent>((event, emit) async {
      print(event.Connectivity);
      try {
        emit(BlogsLoadingState());
        Blogsdb db = Blogsdb.instance;
        await db.initialize();
        
        if (event.Connectivity) {
          List<ArticleModel> articleList = await blogsrepo.fetchArticles();

          emit(BlogsLoadedState(articleList: articleList));
          db.deleteBlogstablecontent();
          db.storeBlogs(articleList);
        } else {
          List<ArticleModel> articleList = await db.retrieveBlogs();
          print(articleList);
          emit(BlogsLoadedState(articleList: articleList));
        }
        db.close();
      } catch (e) {
        emit(BlogsErrorState(errorMessage: e.toString()));
      }
    });
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        add(StartEvent(true));
      } else {
        add(StartEvent(false));
      }
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
//------------------------------------------------------------------------

//--------------------------------------------------------------------

 
 
// import 'package:bloc/bloc.dart';
// import 'package:blog_explorer/bloc/blogsbloc/blogs_event.dart';
// import 'package:blog_explorer/bloc/blogsbloc/blogs_state.dart';
// import 'package:blog_explorer/models/article_model.dart';
// import 'package:blog_explorer/repositories/blogs_repository.dart';




// class BlogsBloc extends Bloc<BlogsEvents, BlogsStates> {
//   Blogsrepo blogsrepo;  

//   BlogsBloc({required BlogsStates initialState, required this.blogsrepo})
//       : super(initialState) {
//     add(StartEvent());
//   }

//   Stream<BlogsStates> mapEventToState(BlogsEvents event) async* {
//     if (event is StartEvent) {
//       try {
//         List<Articlemodel> articleList = [];
//         yield BlogsLoadingState();
        
//         articleList = await blogsrepo.fetchArticles(); 
//         yield BlogsLoadedState(articleList: articleList);
//       } catch (e) {
//         yield BlogsErrorState(errorMessage: e.toString()); 
//       }
//     }
//   }
// }





// import 'package:bloc/bloc.dart';
// import 'package:blog_explorer/bloc/blogsbloc/blogs_event.dart';
// import 'package:blog_explorer/bloc/blogsbloc/blogs_state.dart';
// import 'package:blog_explorer/models/article_model.dart';
// import 'package:blog_explorer/repositories/blogs_repository.dart';

// class BlogsBloc extends Bloc<BlogsEvents, BlogsStates> {
//   Blogsrepo blogsrepo;
//   BlogsBloc({required BlogsStates initialState, required this.blogsrepo})
//       : super(initialState) {
//     add(StartEvent());
//   }

//   Stream<BlogsStates> mapEventToState(BlogsEvents event) async* {
//     if (event is StartEvent) {
//       try {
//         List<Articlemodel> _articleList = [];
//         yield BlogsLoadingState();
//         _articleList = await Blogsrepo.fetchArticles();
//         yield BlogsLoadedState(articleList: _articleList);
//       } catch (e) {
//         yield BlogsErrorState(errorMessage: e);
//       }
//     }
//   }
// }
