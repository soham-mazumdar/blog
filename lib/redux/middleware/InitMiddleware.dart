// import 'package:blog/redux/actions/PostsAction.dart';
// import 'package:redux/redux.dart';
// import 'package:blog/redux/actions/action.dart';
// import 'package:blog/redux/models/app_state.dart';
// import 'package:blog/redux/services/WPService.dart';

// List<Middleware<AppState>> initMiddleware(
// 	WPService wpService,
// ){
// 	return[
//     TypedMiddleware<AppState, InitAppAction>(_init(wpService)),
// 	];
// }

// void Function(Store<AppState> store, InitAppAction action, NextDispatcher next)
// _init(WPService wpService)
// {
//   return (store, action, next) async {

//         wpService.fetchPosts().then((posts){
//           store.dispatch(SavePostsAction(posts));
//           store.dispatch(IsLoadingAction(false));
//         });
//     next(action);
//   };
// }
