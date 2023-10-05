// class Articlemodel {
//   String? id;
//   String? imageUrl;
//   String? title;
  

//   Articlemodel({this.id, this.imageUrl, this.title});

//   Articlemodel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     imageUrl = json['image_url'];
//     title = json['title'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['image_url'] = imageUrl;
//     data['title'] = title;
//     return data;
//   }
// }



class ArticleModel {
  String? id;
  String? imageUrl;
  String? title;
  bool? isFavorite;

  ArticleModel({this.id, this.imageUrl, this.title, this.isFavorite = false});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
    isFavorite = false; // Initialize isFavorite with false during object creation
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['title'] = title;
    return data;
  }
}
