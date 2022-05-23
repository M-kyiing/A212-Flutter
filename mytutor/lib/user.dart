class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? pass;
  String? add;
  String? image;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.pass,
      this.add,
      this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    pass = json['pass'];
    add = json['add'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['pass'] = pass;
    data['add'] = add;
    data['image'] = image;
    return data;
  }
}
