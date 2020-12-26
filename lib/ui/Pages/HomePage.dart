import 'package:blog/redux/actions/PostsAction.dart';
import 'package:blog/redux/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:blog/redux/actions/navigator_actions.dart';
import 'package:blog/redux/models/Post.dart';
import 'package:blog/redux/models/app_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) {
        final Map<String, dynamic> args = {
          "posts": store.state.posts,
          "isLoading": store.state.isLoading,
          "page": store.state.pageNumber,
          "single": (Post post) {
            store.dispatch(SelectedPostAction(post));
            return store.dispatch(NavigatorPushAction(AppRoutes.single));
          },
          "loadMore": (page) {
            store.dispatch(LoadMorePostsAction(page));
          },
        };
        return args;
      },
      builder: (context, args) {
        final bool isLoading = args["isLoading"];
        final List<Post> posts = args["posts"];
        final int page = args["page"];
        final Function single = args["single"];
        final Function loadMore = args["loadMore"];

        _controller.addListener(() {
          if (_controller.hasClients && _controller.position.atEdge) {
            if (_controller.position.pixels == 0) {
              print('top');
            } else {
              print('bottom');
              loadMore(page + 1);
              setState(() {
                _controller =
                    ScrollController(initialScrollOffset: _controller.offset);
              });
            }
          }
        });

        return Scaffold(
          appBar: AppBar(title: Text('Posts from Techcrunch')),
          body: Stack(
            children: [
              Expanded(
                  child: ListView.builder(
                      physics: isLoading
                          ? NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      itemCount: posts.length,
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => single(posts[index]),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.black12,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(posts[index].img),
                                SizedBox(height: 10),
                                Text(
                                  posts[index].title,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Html(
                                  data: posts[index].excerpt,
                                  onLinkTap: (url) {},
                                  onImageTap: (src) {},
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
              isLoading
                  ? Container(
                      color: Colors.white60.withOpacity(0.5),
                      child: Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )))
                  : Container()
            ],
          ),
        );
      },
    );
  }
}
