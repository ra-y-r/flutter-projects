class user {
  String role;
  String name;
  String email;
  String password;
  String passwordRepeat;
  String facebook_url;
  String phone_num;
  String whatsapp_url;
  user(
      {required this.name,
      required this.email,
      required this.role,
      required this.password,
      required this.passwordRepeat,
      required this.facebook_url,
      required this.phone_num,
      required this.whatsapp_url});
}
