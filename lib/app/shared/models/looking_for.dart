class LookingFor {
  String woman;

  String man;

  String cisgender_woman;

  String cisgender_man;

  String transsexual_womam;

  String transsexual_man;

  String transvestite;

  String transgender;

  String not_binary;

  String queer;

  String intersex;

  String other;

  LookingFor({
    this.woman,
    this.man,
    this.cisgender_woman,
    this.cisgender_man,
    this.transsexual_womam,
    this.transsexual_man,
    this.transvestite,
    this.transgender,
    this.not_binary,
    this.queer,
    this.intersex,
    this.other,
  });

  LookingFor.fromJson(Map<String, dynamic> json) {
    // id = json['Id'];
    // name = json['Name'];
    // email = json['Email'];
    woman = json['woman'];
    man = json['man'];
    cisgender_woman = json['cisgender_woman'];
    cisgender_man = json['cisgender_man'];
    transsexual_womam = json['transsexual_womam'];
    transsexual_man = json['transsexual_man'];
    transvestite = json['transvestite'];
    transgender = json['transgender'];
    not_binary = json['not_binary'];
    queer = json['queer'];
    intersex = json['intersex'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['woman'] = this.woman;

    data['man'] = this.man;

    data['cisgender_woman'] = this.cisgender_woman;

    data['cisgender_man'] = this.cisgender_man;

    data['transsexual_womam'] = this.transsexual_womam;

    data['transsexual_man'] = this.transsexual_man;

    data['transvestite'] = this.transvestite;

    data['transgender'] = this.transgender;

    data['not_binary'] = this.not_binary;

    data['queer'] = this.queer;

    data['intersex'] = this.intersex;

    data['other'] = this.other;
    return data;
  }
}
