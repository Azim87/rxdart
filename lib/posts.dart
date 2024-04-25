class Posts {
  final String title;
  final String body;

  Posts(this.title, this.body);

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        json['title'] as String,
        json['body'] as String,
      );
}
