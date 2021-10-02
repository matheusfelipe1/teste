class Ways {
  String icon;
  String iconLight;
  String title;
  String description;
  String id;

  Ways({this.icon, this.title, this.description, this.iconLight, this.id});

  Ways.fromJson(Map<String, dynamic> json) {
    icon = json['Icon'];
    iconLight = json['IconLight'];
    title = json['Title'];
    description = json['Description'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Icon'] = this.icon;
    data['IconLight'] = this.iconLight;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Id'] = this.id;
    return data;
  }
}
