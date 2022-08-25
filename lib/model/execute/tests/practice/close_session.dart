class CloseSession {
  String? message;
  String? code;
  String? sessionId;

  CloseSession({this.message, this.code, this.sessionId});

  CloseSession.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    sessionId = json['sessionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['sessionId'] = this.sessionId;
    return data;
  }
}
