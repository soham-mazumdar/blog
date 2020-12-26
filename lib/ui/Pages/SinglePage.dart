import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:blog/redux/models/Post.dart';
import 'package:blog/redux/models/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SinglePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) {
        final Map<String, dynamic> args = {
          "post": store.state.selectedPost,
        };
        return args;
      },
      builder: (context, args) {
        final Post post = args["post"];

        return Scaffold(
          appBar: AppBar(title: Text(post.title)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(post.img),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        post.title,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Html(
                        data: post.content,
                        blacklistedElements: ["iframe"],
                        onLinkTap: (String url) async {
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
