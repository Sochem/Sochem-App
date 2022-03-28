class Book {
  late String title;
  late String imageAddress;

  Book(this.title, this.imageAddress);

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageAddress = json['imageAddress'];
  }
}
