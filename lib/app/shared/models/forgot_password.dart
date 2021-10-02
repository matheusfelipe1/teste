class ForgotPassword {
  String email;
  String password;

  ForgotPassword({this.email, this.password});

  ForgotPassword.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    email = json['email'];
  }
}
