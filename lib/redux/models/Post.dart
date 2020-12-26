
class Post {
  final int id;
  final String title;
  final String content;
  final String excerpt;
  final String img;

  Post({
    this.id,
    this.title,
    this.content,
    this.excerpt,
    this.img,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      excerpt: json['excerpt']['rendered'],
      img: json['_embedded']['wp:featuredmedia'][0]['source_url'],
    );
  }

   Map<String, dynamic> toJson() => {
		"id": id,
		"title": title,
		"content": content,
    "excerpt": excerpt,
    "img": img,
	};
}