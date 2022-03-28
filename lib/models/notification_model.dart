class Notificationss {
  String? id;
  String? title;
  String? description;
  String? type;

  Notificationss(this.id, this.title, this.description, this.type);

  Notificationss.fromJson(Map<String, dynamic> info) {
    id = info['id'].toString();
    title = info['title'];
    description = info['description'];
    type = info['type'].toString();
  }
}
