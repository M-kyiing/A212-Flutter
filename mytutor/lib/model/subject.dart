class Subject {
  String? subID;
  String? subName;
  String? subDesc;
  String? subPrice;
  String? subSessions;
  String? subImage;

  Subject(
      {this.subID,
      this.subName,
      this.subDesc,
      this.subPrice,
      this.subSessions,
      this.subImage});

  Subject.fromJson(Map<String, dynamic> json) {
    subID = json['subID'];
    subName = json['subName'];
    subDesc = json['subDesc'];
    subPrice = json['subPrice'];
    subSessions = json['subSessions'];
    subImage = json['subImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subID'] = subID;
    data['subName'] = subName;
    data['subDesc'] = subDesc;
    data['subPrice'] = subPrice;
    data['subSessions'] = subSessions;
    data['subImage'] = subImage;
    return data;
  }
}
