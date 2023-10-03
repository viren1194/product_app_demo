class EditRegisterBody {
  String? name;
  String? email;
  String? password;
  String? avatar;

  EditRegisterBody({this.name, this.email, this.password, this.avatar});

  EditRegisterBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    return data;
  }
}