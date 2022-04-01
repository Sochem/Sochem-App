class HomeCarousel {
  late String title;
  late String imageAddress;

  HomeCarousel(this.title, this.imageAddress);

  HomeCarousel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageAddress = json['img'];
  }
}
