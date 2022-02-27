
class NewsModel {
  late String? author;
  late String? title;
  late String? description;
  late String? url;
  late String? urlToImage;
  late String? content;
  late String? publishedAt;

  NewsModel(
       this.author,
       this.title,
       this.description,
       this.url,
       this.urlToImage,
       this.content,
       this.publishedAt);

  NewsModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    author = parsedJson['author'];
    title = parsedJson['title'];
    description = parsedJson['description'];
    url = parsedJson['url'];
    urlToImage = parsedJson['urlToImage'];
    publishedAt = parsedJson['publishedAt'];
    content = parsedJson['content'];
  }
  Map<String, dynamic> toMap(){
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
