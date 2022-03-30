class Post {
  late int id;
  late String title;
  late String date;
  late String description;
  late String venue;
  late var cover1;
  late var cover2;
  late var file1;
  late var file2;

  Post({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.venue,
    required this.cover1,
    required this.cover2,
    required this.file1,
    required this.file2,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    title = json['title'];
    date = json['date'];
    venue = json['venue'];
    cover1 = json['cover1'];
    cover2 = json['cover2'];
    file1 = json['file1'];
    file2 = json['file2'];
  }
}
