class Post {
  late String authorName;
  late String authorImageUrl;
  // late DateTime timeAgo;
  late String imageUrl;
  late String postHeading;
  late String postDesc;

  Post({
    required this.authorName,
    required this.authorImageUrl,
    // required this.timeAgo,
    required this.imageUrl,
    required this.postHeading,
    required this.postDesc,
  });

  Post.fromJson(Map<String, dynamic> json) {
    authorName = json['authorName'];
    imageUrl = json['imageUrl'];
    authorImageUrl = json['authorImageUrl'];
    // timeAgo = json['timeAgo'];
    postHeading = json['postHeading'];
    postDesc = json['postDesc'];
  }
}
