class IdAndLabel {
  String id;
  String label;

  IdAndLabel({this.id, this.label});

  IdAndLabel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    label = json['Label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Label'] = this.label;
    return data;
  }
}
