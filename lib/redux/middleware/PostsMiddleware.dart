
import 'package:blog/redux/actions/PostsAction.dart';
import 'package:blog/redux/actions/action.dart';
import 'package:blog/redux/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:blog/redux/services/WPService.dart';

List<Middleware<AppState>> postsMiddleware(
  WPService wpService,
){
	return[
    TypedMiddleware<AppState, InitAppAction>(_init(wpService)),
    TypedMiddleware<AppState, LoadMorePostsAction>(_loadMorePosts(wpService)),
	];
}

void Function(Store<AppState> store, InitAppAction action, NextDispatcher next)
_init(WPService wpService)
{
  return (store, action, next) async {

        wpService.fetchPosts().then((posts){
          store.dispatch(SavePostsAction(posts));
          store.dispatch(IsLoadingAction(false));
        });
    next(action);
  };
}

void Function(Store<AppState> store, LoadMorePostsAction action, NextDispatcher next)
_loadMorePosts(WPService wpService)
{
  return (store, action, next) 
  async {

    store.dispatch(IsLoadingAction(true));
    wpService.fetchMorePosts(action.page).then((thoughts){
      store.dispatch(SavePostsAction(thoughts));
      store.dispatch(SavePageAction(action.page));
      store.dispatch(IsLoadingAction(false));
    });
    
    next(action);

  };
}

