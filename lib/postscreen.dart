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
  List<Post> posts = [];
  fetchPosts() async {
    try {
      posts.clear();
      final Dio dio = Dio();
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );
      for (var post in response.data) {
        posts.add(Post.fromMap(post));
      }
      return posts;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.postViewScreen);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Post> posts = snapshot.data as List<Post>;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:
                      () => Navigator.of(context).pushNamed(
                        AppRoutes.postViewScreen,
                        arguments: posts[index].id,
                      ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Card(
                      shadowColor: Colors.black,
                      child: ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(
                          posts[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          posts[index].body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
