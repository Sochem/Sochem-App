class Config {
  late String appVersion;
  late bool maintenance;
  late bool update;

  Config(this.appVersion, this.maintenance, this.update);

  Config.fromJson(Map<String, dynamic> json) {
    appVersion = json['app_version'];
    maintenance = json['maintenance'];
    update = json['update'];
  }
}
