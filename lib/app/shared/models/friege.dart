class Fridge {
  String id;
  String name;
  List<String> photos;
  Sign sign;

  Fridge(
      {this.id,
      this.name,
      this.photos,
      this.sign,
      });

  Fridge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sign = json['sign'] != null ? Sign.fromJson(json['sign']) : new Sign(sunSign: "", botResponse: "");

    var listPhotos = json['photo'];
    if (listPhotos is List) {
      this.photos = new List<String>();
      for (var item in listPhotos) {
        if (item != null) this.photos.add(item);
      }
    }    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photos;

    return data;
  }
}

class Sign {
  String botResponse;
  String sunSign;

  Sign({this.botResponse, this.sunSign});

  Sign.fromJson(Map<String, dynamic> json) {
    botResponse = json['bot_response'];
    sunSign = json['sun_sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bot_response'] = this.botResponse;
    data['sun_sign'] = this.sunSign;
    return data;
  }
}