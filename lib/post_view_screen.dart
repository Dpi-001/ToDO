import 'package:flutter/material.dart';

class postviewScreen extends StatefulWidget {
  const postviewScreen({super.key});

  @override
  State<postviewScreen> createState() => _postviewScreenState();
}

class _postviewScreenState extends State<postviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Post View Screen')));
  }
}
