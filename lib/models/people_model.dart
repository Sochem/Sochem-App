class People {
  String? img;
  String? name;
  String? email;

  People(this.img, this.name, this.email);
  People.fromJson(Map<String, dynamic> info) {
    img = info['img'];
    name = info['name'];
    email = info['email'];
  }
}
