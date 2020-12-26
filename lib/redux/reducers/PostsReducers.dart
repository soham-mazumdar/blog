import 'package:blog/redux/actions/action.dart';
import 'package:redux/redux.dart';
import 'package:blog/redux/actions/PostsAction.dart';
import 'package:blog/redux/models/Post.dart';

final thoughtsReducer = combineReducers<List<Post>>([TypedReducer<List<Post>, SavePostsAction>(_savePosts),]);
List<Post> _savePosts(List<Post> thoughts, SavePostsAction action)
{
  thoughts.addAll(action.posts);
  return thoughts;
}


final selectedPost = combineReducers<Post>([TypedReducer<Post, SelectedPostAction>(_selectedPost),]);
Post _selectedPost(Post posts, SelectedPostAction action) => action.postID;


final isLoadingReducer = combineReducers<bool>([TypedReducer<bool, IsLoadingAction>(_saveIsLoading)]);
bool _saveIsLoading(bool isLoading, IsLoadingAction action) => action.isLoading;


final pageReducer = combineReducers<int>([TypedReducer<int, SavePageAction>(_savePage)]);
int _savePage(int isLoading, SavePageAction action) => action.page;
