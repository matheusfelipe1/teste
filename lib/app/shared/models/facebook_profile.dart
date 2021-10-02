class FacebookProfile {
  String id;
  String name;
  String firstName;
  String lastName;
  String email;
  String picture;
  String accessToken;

  FacebookProfile({this.id, this.name, this.email, this.accessToken});

  FacebookProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    picture = json['picture'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['accessToken'] = this.accessToken;
    return data;
  }
}