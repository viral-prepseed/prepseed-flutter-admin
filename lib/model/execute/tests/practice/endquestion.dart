class EndQuestion{

  String? message;
  String? code;

  EndQuestion({this.message, this.code});

  EndQuestion.fromJson(Map<String, dynamic> json) {
  message = json['message'];
  code = json['code'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['message'] = this.message;
  data['code'] = this.code;
  return data;
  }

}