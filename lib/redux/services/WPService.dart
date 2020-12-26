import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:blog/redux/models/Post.dart';

const wpBaseUrl = 'https://techcrunch.com';
const wpBaseUrl2 = 'techcrunch.com';

class WPService {
  

  Future<List<Post>> fetchPosts() async{
    String baseUrl = wpBaseUrl2;
    var queryParameters = {'per_page': '20','_embed':'true'};
    var uri = Uri.http(baseUrl , '/wp-json/wp/v2/posts', queryParameters);

    return http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
    ).then((http.Response value) async {
      List body = jsonDecode(value.body);
      List<Post> posts = [];
      for(var e in body){
        posts.add(Post.fromJson(e));
      }

      return posts;
    });
  }

  Future<List<Post>> fetchMorePosts(int page) async{
    String baseUrl = wpBaseUrl2;
    var queryParameters = {'per_page': '20','_embed':'true','page': page.toString()};
    var uri = Uri.http(baseUrl , '/wp-json/wp/v2/posts', queryParameters);

    return http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
    ).then((http.Response value) async {
      List body = jsonDecode(value.body);
      log(body.toString());
      List<Post> posts = [];
      for(var e in body){
        posts.add(Post.fromJson(e));
      }
      return posts;
    });
  }

  
  
}