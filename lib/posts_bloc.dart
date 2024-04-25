import 'package:flutter_rxdart/posts.dart';
import 'package:flutter_rxdart/posts_service.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc {
  final _postsSubject = BehaviorSubject<List<Posts>>();
  final _loadingSubject = BehaviorSubject<bool>.seeded(false);

  Stream<List<Posts>> get postsStream => _postsSubject.stream;

  Stream<bool> get loadingStream => _loadingSubject.stream;

  final PostsService _postsService = PostsService();

  void dispose() {
    _postsSubject.close();
    _loadingSubject.close();
  }

  void fetchPosts() async {
    _loadingSubject.add(true);

    try {
      final postsList = await _postsService.fetchPosts();
      _postsSubject.add(postsList);
    } catch (error) {
      _postsSubject.addError(error);
    } finally {
      _loadingSubject.add(false);
    }
  }
}
