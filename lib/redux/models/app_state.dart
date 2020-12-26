import 'package:blog/redux/models/Post.dart';
import 'package:blog/redux/routes/routes.dart';

class AppState {
  final List<Post> posts;
  final bool isLoading;
  final int pageNumber;
  final Post selectedPost;
  
  final List<String> routes;
  

  AppState({
    this.posts,
    this.isLoading,
    this.pageNumber,
    this.selectedPost,
    
    this.routes,
  });

  factory AppState.initial(){
    return AppState(
      isLoading: true,
      posts: [],
      pageNumber: 1,
      
      routes: [AppRoutes.home],
    );
  }

  AppState copyWith({
    List<Post> newPosts,
    bool newIsLoading,
    int newPageNumber,
    Post newSelectedPost,
    
    List<String> newRoutes,
  })
  {
    return AppState(
      posts: newPosts ?? this.posts,
      isLoading: newIsLoading ?? this.isLoading,
      pageNumber: newPageNumber ?? this.pageNumber,
      selectedPost: newSelectedPost ?? this.selectedPost,
      
      routes: newRoutes ?? this.routes,
    );
  }
}