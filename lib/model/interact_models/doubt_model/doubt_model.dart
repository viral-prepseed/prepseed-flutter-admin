class DoubtModel {
  bool? success;
  List<Subjects>? subjects;

  DoubtModel({this.success, this.subjects});

  DoubtModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  bool? isColorDark;
  List<String>? topics;
  String? sId;
  String? name;
  String? shortName;
  String? color;
  String? textColor;
  String? thumbnail;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Subjects(
      {this.isColorDark,
        this.topics,
        this.sId,
        this.name,
        this.shortName,
        this.color,
        this.textColor,
        this.thumbnail,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Subjects.fromJson(Map<String, dynamic> json) {
    isColorDark = json['isColorDark'];
    topics = json['topics'].cast<String>();
    sId = json['_id'];
    name = json['name'];
    shortName = json['shortName'];
    color = json['color'];
    textColor = json['textColor'];
    thumbnail = json['thumbnail'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isColorDark'] = this.isColorDark;
    data['topics'] = this.topics;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['color'] = this.color;
    data['textColor'] = this.textColor;
    data['thumbnail'] = this.thumbnail;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}