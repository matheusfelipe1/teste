class CardModel {
  String id;
  String name;
  //String image;
  int age;
  int percent;
  String sign;
  String content;
  CardType type;
  int distance;
  List<String> waysOfLove;
  List<String> goals;
  List<String> interestedIn;
  List<String> lookingFor;
  List<String> photos;
  String state;
  String city;

  CardModel(
      {this.id,
      this.name,
      //this.image,
      this.age,
      this.percent,
      this.sign,
      this.content,
      this.type,
      this.distance,
      this.waysOfLove,
      this.goals,
      this.interestedIn,
      this.lookingFor,
      this.photos,
      this.state,
      this.city});

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    //image = json['Image'];
    age = json['age'];
    percent = json['synastry'];
    sign = json['sign'];
    content = json['about'];
    type = json['Type'];
    distance = json['distance'];

    var listWays = json['way_of_love'];
    if (listWays is List) {
      this.waysOfLove = new List<String>();
      for (var item in listWays) {
        if (item != null) this.waysOfLove.add(item);
      }
    }

    var listGoals = json['goals'];
    if (listGoals is List) {
      this.goals = new List<String>();
      for (var item in listGoals) {
        if (item != null) this.goals.add(item);
      }
    }

    var listInterested = json['interested_in'];
    if (listInterested is List) {
      this.interestedIn = new List<String>();
      for (var item in listInterested) {
        if (item != null) this.interestedIn.add(item);
      }
    }

    var listLookings = json['looking_for'];
    if (listLookings is List) {
      this.lookingFor = new List<String>();
      for (var item in listLookings) {
        if (item != null) this.lookingFor.add(item);
      }
    }

    var listPhotos = json['photo'];
    if (listPhotos is List) {
      this.photos = new List<String>();
      for (var item in listPhotos) {
        if (item != null) this.photos.add(item);
      }
    }

    state = json['state_or_province'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    //data['Image'] = this.image;
    data['age'] = this.age;
    data['synastry'] = this.percent;
    data['sign'] = this.sign;
    data['about'] = this.content;
    data['Type'] = this.type;
    data['distance'] = this.distance;
    data['way_of_love'] = this.waysOfLove;
    data['goals'] = this.goals;
    data['interested_in'] = this.interestedIn;
    data['looking_for'] = this.lookingFor;
    data['photo'] = this.photos;
    data['state_or_province'] = this.state;
    data['city'] = this.city;
    return data;
  }
}

enum CardType {
  profile,
  content,
  publicity,
}
