import 'package:flutter/material.dart';
import 'package:flutter_rxdart/posts.dart';
import 'package:flutter_rxdart/posts_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostsBloc _postsBloc = PostsBloc();

  @override
  void initState() {
    super.initState();
    _postsBloc.fetchPosts();
  }

  @override
  void dispose() {
    _postsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<List<Posts>>(
          stream: _postsBloc.postsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final post = snapshot.data!;

              return ListView.builder(
                itemCount: post.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    Text(
                      'Name: ${post[2].title}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'body: ${post[2].body}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
}
