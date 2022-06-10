class Subject {
  String? subID;
  String? subName;
  String? subDesc;
  String? subPrice;
  String? subSessions;
  String? subRating;
  String? tutorID;

  Subject(
      {this.subID,
      this.subName,
      this.subDesc,
      this.subPrice,
      this.subSessions,
      this.subRating,
      this.tutorID});

  Subject.fromJson(Map<String, dynamic> json) {
    subID = json['subject_id'];
    subName = json['subject_name'];
    subDesc = json['subject_description'];
    subPrice = json['subject_price'];
    tutorID = json['tutor_id'];
    subSessions = json['subject_sessions'];
    subRating = json['subject_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subID;
    data['subject_name'] = subName;
    data['subject_description'] = subDesc;
    data['subject_price'] = subPrice;
    data['tutor_id'] = tutorID;
    data['subject_sessions'] = subSessions;
    data['subject_rating'] = subRating;

    return data;
  }
}
