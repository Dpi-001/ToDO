import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/post.dart';

class postviewScreen extends StatefulWidget {
  const postviewScreen({super.key});

  @override
  State<postviewScreen> createState() => _postviewScreenState();
}

class _postviewScreenState extends State<postviewScreen> {
  Post? post;

  fetchPostDetail() async {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    final Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts/$id',
      );
      post = Post.fromMap(response.data);
      return post;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    print(id);
    return FutureBuilder(
      future: fetchPostDetail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {}
        if (snapshot.hasData) {
          post = snapshot.data as Post;
          return Scaffold(
            appBar: AppBar(title: const Text('Post View')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post!.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(post!.body, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
