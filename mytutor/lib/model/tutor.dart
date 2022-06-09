class Tutor {
  String? tutorID;
  String? tutorName;
  String? tutorEmail;
  String? tutorPhone;
  String? tutorPass;
  String? tutorDesc;
  String? tutorDateReg;
  String? image;

  Tutor(
      {this.tutorID,
      this.tutorName,
      this.tutorEmail,
      this.tutorPhone,
      this.tutorPass,
      this.tutorDesc,
      this.tutorDateReg,
      this.image});

  Tutor.fromJson(Map<String, dynamic> json) {
    tutorID = json['id'];
    tutorName = json['name'];
    tutorEmail = json['email'];
    tutorPhone = json['phone'];
    tutorPass = json['pass'];
    tutorDesc = json['desc'];
    tutorDateReg = json['datereg'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = tutorID;
    data['name'] = tutorName;
    data['email'] = tutorEmail;
    data['phone'] = tutorPhone;
    data['pass'] = tutorPass;
    data['desc'] = tutorDesc;
    data['datereg'] = tutorDateReg;
    data['image'] = image;
    return data;
  }
}
