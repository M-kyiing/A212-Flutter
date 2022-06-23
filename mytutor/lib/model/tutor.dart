class Tutor {
  String? tutorID;
  String? tutorEmail;
  String? tutorPhone;
  String? tutorName;
  String? tutorPass;
  String? tutorDesc;
  String? tutorDateReg;
  String? subjectName;

  Tutor(
      {this.tutorID,
      this.tutorEmail,
      this.tutorPhone,
      this.tutorName,
      this.tutorPass,
      this.tutorDesc,
      this.tutorDateReg,
      this.subjectName});

  Tutor.fromJson(Map<String, dynamic> json) {
    tutorID = json['tutor_id'];
    tutorEmail = json['tutor_email'];
    tutorPhone = json['tutor_phone'];
    tutorName = json['tutor_name'];
    tutorPass = json['tutor_password'];
    tutorDesc = json['tutor_description'];
    tutorDateReg = json['tutor_datereg'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tutor_id'] = tutorID;
    data['tutor_email'] = tutorEmail;
    data['tutor_phone'] = tutorPhone;
    data['tutor_name'] = tutorName;
    data['tutor_password'] = tutorPass;
    data['tutor_description'] = tutorDesc;
    data['tutor_datereg'] = tutorDateReg;
    data['subject_name'] = subjectName;
    return data;
  }
}
