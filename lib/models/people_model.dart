class People {
  String? id;
  String? name;
  String? email;
  String? rollNo;
  String? batch;
  String? house;

  People(this.id, this.name, this.email, this.rollNo, this.batch, this.house);
  People.fromJson(Map<String, dynamic> info) {
    id = info['id'].toString();
    name = info['name'];
    email = info['email'];
    rollNo = info['roll_no'].toString();
    batch = info['batch'].toString();
    house = info['house'];
  }
}
