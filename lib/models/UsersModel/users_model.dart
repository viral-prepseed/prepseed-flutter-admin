

class UsersModel {
  String? dp;
  String? sId;
  String? name;

  UsersModel({this.dp, this.sId, this.name});

  UsersModel.fromJson(Map<String, dynamic> json) {
    dp = json['dp'];
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dp'] = this.dp;
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
