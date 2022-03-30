class Notifications {
  late String id;
  late String title;
  late String description;
  late String type;

  Notifications(this.id, this.title, this.description, this.type);

  Notifications.fromJson(Map<String, dynamic> info) {
    id = info['id'].toString();
    title = info['title'];
    description = info['description'];
    type = info['type'].toString();
  }
}
