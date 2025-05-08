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
          return Scaffold(appBar: AppBar(title: const Text('Post View')));
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
