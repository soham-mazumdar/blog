import 'package:blog/redux/actions/action.dart';
import 'package:blog/redux/models/Post.dart';

// class RefreshAction extends AppAction {}

class SavePostsAction extends AppAction{
  final List<Post> posts;
  SavePostsAction(this.posts);

  @override String toString() => "SavePostsAction{$posts}";
}

class SelectedPostAction extends AppAction{
  final Post postID;
  SelectedPostAction(this.postID);

  @override String toString() => "SelectedPostAction{$postID}";
}

class LoadMorePostsAction extends AppAction {
  final int page;
  LoadMorePostsAction(this.page);

  @override String toString() => "LoadMorePostsAction{$page}";
  
}

class SavePageAction extends AppAction{
  final int page;
  SavePageAction(this.page);

  @override String toString() => "SavePageAction{$page}";
}
