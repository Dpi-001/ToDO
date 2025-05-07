// postscreeneg.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_routes.dart';
import 'package:flutter_application_1/model/post.dart';

class Postscreeneg extends StatefulWidget {
  const Postscreeneg({super.key});

  @override
  State<Postscreeneg> createState() => _PostscreenegState();
}

class _PostscreenegState extends State<Postscreeneg> {
  List<Post> fetchedPosts = [];

  Future<List<Post>> fetchPost() async {
    final response = await Dio().get(
      'https://jsonplaceholder.typicode.com/posts',
    );
    try {
      if (response.statusCode == 200) {
        for (var item in response.data) {
          fetchedPosts.add(Post.fromMap(item));
        }
        return fetchedPosts;
      }
    } catch (e) {
      print(e.toString());
    }

    if (response.statusCode == 200) {
      for (var item in response.data) {
        fetchedPosts.add(Post.fromMap(item));
      }
      return fetchedPosts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Screen')),
      body: FutureBuilder<List<Post>>(
        future: fetchPost(),
        builder: (context, snapshot) {
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (ctx, index) {
              final post = posts[index];

              return GestureDetector(
                onTap:
                    () => Navigator.of(context).pushNamed(
                      AppRoutes.postViewScreen,
                      arguments: posts[index].id,
                    ),
                child: ListTile(
                  leading: Text(post.userId.toString()),
                  trailing: Text(post.id.toString()),
                  title: Text(
                    post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
