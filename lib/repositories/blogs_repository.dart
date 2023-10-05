import 'package:blog_explorer/models/article_model.dart';
import 'package:dio/dio.dart';


// class Blogsrepo {
//   Dio dio = Dio(BaseOptions(
//     baseUrl: "https://intent-kit-16.hasura.app/api/rest/",
//     headers: {
//       "x-hasura-admin-secret":
//           "32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6"

//       //"Authorization": "Bearer YOUR_ACCESS_TOKEN",
//     },
//   ));

//   Future<List<Articlemodel>> fetchArticles() async {
//     try {
//       Response response = await dio.get("blogs");
//       Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
//       print(response);

//       if (responseData.containsKey("blogs")) {
//         List<dynamic> jsonList = responseData["blogs"];

//         List<Articlemodel> articles =
//             jsonList.map((json) => Articlemodel.fromJson(json)).toList();

//         return articles;
//       } else {
//         throw Exception(
//             "Failed to load articles: 'blogs' key not found in the response");
//       }
//     } catch (error) {
//       throw Exception("Failed to load articles: $error");
//     }
//   }
// }

class BlogsRepo {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://intent-kit-16.hasura.app/api/rest/",
    headers: {
      "x-hasura-admin-secret":
          "32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6",
    },
  ));

  Future<List<ArticleModel>> fetchArticles() async {
    try {
      Response response = await dio.get("blogs");
      Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      print(response);

      if (responseData.containsKey("blogs")) {
        List<dynamic> jsonList = responseData["blogs"];
        List<ArticleModel> articles = jsonList
            .map((json) => ArticleModel.fromJson(json)..isFavorite = true)
            .toList();

        return articles;
      } else {
        throw Exception(
            "Failed to load articles: 'blogs' key not found in the response");
      }
    } catch (error) {
      throw Exception("Failed to load articles: $error");
    }
  }
}

