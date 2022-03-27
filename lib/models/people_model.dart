class People {
  String? img;
  String? name;
  String? email;
  String? house;

  People(this.img, this.name, this.email, this.house);
  People.fromJson(Map<String, dynamic> info) {
    img = info['img'];
    name = info['name'];
    email = info['email'];
    house = info['house'];
  }
}
