import 'package:blog/redux/actions/action.dart';
import 'package:blog/redux/middleware/middleware.dart';
import 'package:blog/redux/models/app_state.dart';
import 'package:blog/redux/reducers/base_reducer.dart';
import 'package:blog/redux/routes/routes.dart';
import 'package:blog/redux/services/WPService.dart';
import 'package:blog/ui/Pages/HomePage.dart';
import 'package:blog/ui/Pages/SinglePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Store<AppState> store = Store<AppState>(
    baseReducer,
    initialState: AppState.initial(),
    
    middleware: createMiddleWare(
      navigatorKey,
      WPService()
    )
  );
  store.dispatch(InitAppAction());
  return runApp(HindApp(store));
}

class HindApp extends StatelessWidget {
  
  final Store<AppState> store;

  HindApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner : false,
        navigatorKey:navigatorKey,
        navigatorObservers: [routeObserver],
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            headline1: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        onGenerateRoute: (RouteSettings settings) => _resolveRoute(settings),
      ),
    );
  }

  MaterialPageRoute _resolveRoute(RouteSettings settings)
	{
		switch(settings.name)
		{
			case AppRoutes.single:
		   	return FabRoute(SinglePage(), settings: settings, duration: 400, direction: 'right');
      default :
        return MainRoute(HomePage(), settings : settings,);
		}
	}
}

