import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:blog/redux/middleware/PostsMiddleware.dart';
import 'package:blog/redux/middleware/navigation_middleware.dart';
import 'package:blog/redux/models/app_state.dart';
import 'package:blog/redux/services/WPService.dart';

List<Middleware<AppState>> createMiddleWare(
  GlobalKey<NavigatorState> navigatorKey,
  WPService wpService
)
{
  return [
    ...createNavigationMiddleware(navigatorKey),
    ...postsMiddleware(wpService)
  ];
}