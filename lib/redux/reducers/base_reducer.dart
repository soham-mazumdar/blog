
import 'package:blog/redux/models/app_state.dart';
import 'package:blog/redux/reducers/PostsReducers.dart';
import 'package:blog/redux/reducers/navigation_reducer.dart';

AppState baseReducer(AppState oldState, dynamic action)
{
  return oldState.copyWith(
    newPosts: thoughtsReducer(oldState.posts, action),
    newIsLoading: isLoadingReducer(oldState.isLoading, action),
    newSelectedPost: selectedPost(oldState.selectedPost, action),
    newPageNumber: pageReducer(oldState.pageNumber, action),
    
    newRoutes: navigationReducer(oldState.routes, action),
  );
}