class Profile {
  String id;
  String name;
  String mobileNumber;
  String email;
  MapLocation location;
  String about;
  String token;
  Birth birth;
  Sign sign;
  Configuration configuration;
  // String waysOfLove;
  List<String> photos;
  List<String> genders;
  List<String> waysOfLove;
  List<String> goals;
  List<String> interestedIn;
  List<String> lookingFor;
  String password;

  Profile(
      {this.id,
      this.name,
      this.mobileNumber,
      this.email,
      this.location,
      this.photos,
      this.about,
      this.genders,
      this.birth,
      this.sign,
      this.configuration,
      this.waysOfLove,
      this.goals,
      this.token,
      this.interestedIn,
      this.lookingFor});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    token = json['token'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    location = json['location'] != null
        ? MapLocation.fromJson(json['location'])
        : null;

    var listPhotos = json['photo'];
    if (listPhotos is List) {
      this.photos = new List<String>();
      for (var item in listPhotos) {
        if (item != null) this.photos.add(item);
      }
    }

    about = json['about'];

    var listGenders = json['genders'];
    if (listGenders is List) {
      this.genders = new List<String>();
      for (var item in listGenders) {
        if (item != null) this.genders.add(item);
      }
    }

    birth = json['birth'] != null ? Birth.fromJson(json['birth']) : null;
    sign = json['sign'] != null
        ? Sign.fromJson(json['sign'])
        : new Sign(sunSign: "", botResponse: "");
    configuration = json['configuration'] != null
        ? Configuration.fromJson(json['configuration'])
        : new Configuration(
            age: new MinMax(min: 20.0, max: 35.0),
            distance: new MinMax(min: 0.0, max: 20.0));

    waysOfLove = json['ways_of_love'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if(id != null)
    //   data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['location'] = this.location.toJson();
    data['birth'] = this.birth.toJson();
    // data['sign'] = this.sign.toJson();
    data['photo'] = this.photos;
    data['about'] = this.about;
    data['photo'] = this.photos;
    data['genders'] = this.genders;
    data['way_of_love'] = this.waysOfLove;
    data['goals'] = this.goals;
    data['interested_in'] = this.interestedIn;
    data['looking_for'] = this.lookingFor;
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

class MapLocation {
  double latitude;
  double longitude;

  MapLocation({this.latitude, this.longitude});

  MapLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Birth {
  Place place;
  String date;
  String time;

  Birth({this.place, this.date, this.time});

  Birth.fromJson(Map<String, dynamic> json) {
    place = Place.fromJson(json['place']);
    date = json['date_birth'];
    time = json['time_birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place'] = this.place.toJson();
    data['date_birth'] = this.date;
    data['time_birth'] = this.time;
    return data;
  }
}

class Place {
  String city;

  Place({this.city});

  Place.fromJson(Map<String, dynamic> json) {
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    return data;
  }
}

class Configuration {
  MinMax age;
  MinMax distance;

  Configuration({this.age, this.distance});

  Configuration.fromJson(Map<String, dynamic> json) {
    age = MinMax.fromJson(json['age']);
    distance = MinMax.fromJson(json['distance']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age.toJson();
    data['distance'] = this.distance.toJson();
    return data;
  }
}

class MinMax {
  double min;
  double max;

  MinMax({this.min, this.max});

  MinMax.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}
