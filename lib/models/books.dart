class Book {
  late String category;
  late String imageAddress;
  late String link;

  Book(this.category, this.imageAddress, this.link);

  Book.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    imageAddress = json['imageAddress'];
    link = json['link'];
  }
}
