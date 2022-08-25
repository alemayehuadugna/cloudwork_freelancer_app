import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets.dart';

class SinglePostPage extends StatelessWidget {
  final String? postId;
  const SinglePostPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = Post.posts[int.parse(postId!) - 1];
    // final isMobile = ResponsiveWrapper.of(context).isMobile;
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        leading: BackButton(
          onPressed: () => context.pop(),
        ),
      ),
      backgroundColor: post.color,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                post.title,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
