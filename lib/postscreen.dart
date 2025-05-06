// postscreeneg.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/post.dart';

class Postscreeneg extends StatefulWidget {
  const Postscreeneg({super.key});

  @override
  State<Postscreeneg> createState() => _PostscreenegState();
}

class _PostscreenegState extends State<Postscreeneg> {
  Future<List<Post>> fetchPost() async {
    final response = await Dio().get(
      'https://jsonplaceholder.typicode.com/posts',
    );

    if (response.statusCode == 200) {
      for (var item in response.data) {
        fetchedPosts.add(Post.fromMap(item));
      }
      return fetchedPosts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  List<Post> fetchedPosts = [];

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
              return ListTile(
                leading: Text(post.userId.toString()),
                trailing: Text(post.id.toString()),
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        },
      ),
    );
  }
}
