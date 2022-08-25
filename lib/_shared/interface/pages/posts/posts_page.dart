import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../_core/router/go_routes.dart';
import 'widgets.dart';

class PostsPage extends StatelessWidget {
  PostsPage({Key? key}) : super(key: key);
  final posts = Post.posts;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < posts.length; i++)
              PostTile(
                tileColor: posts[i].color,
                postTitle: posts[i].title,
                onTileTap: () {
                  context.goNamed(
                    postDetailsRouteName,
                    params: {'post': posts[i].id.toString()},
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
