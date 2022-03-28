class People {
  String? id;
  String? name;
  String? email;
  String? roll_no;
  String? batch;
  String? house;

  People(this.id, this.name, this.email, this.roll_no, this.batch, this.house);
  People.fromJson(Map<String, dynamic> info) {
    id = info['id'].toString();
    name = info['name'];
    email = info['email'];
    roll_no = info['roll_no'].toString();
    batch = info['batch'].toString();
    house = info['house'];
  }
}
