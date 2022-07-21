class CommentModel {
  List<Item>? item;
  int? refreshInterval;
  String? lastCommentAt;
  Item? lastComment;

  CommentModel(
      {this.item, this.refreshInterval, this.lastCommentAt, this.lastComment});

  CommentModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      item = <Item>[];
      json['items'].forEach((v) {
        item!.add(Item.fromJson(v));
      });
    }
    refreshInterval = json['refreshInterval'];
    lastCommentAt = json['lastCommentAt'];
    lastComment = json['lastComment'] != null
        ? Item.fromJson(json['lastComment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (item != null) {
      data['items'] = item!.map((v) => v.toJson()).toList();
    }
    data['refreshInterval'] = refreshInterval;
    data['lastCommentAt'] = lastCommentAt;
    if (lastComment != null) {
      data['lastComment'] = lastComment!.toJson();
    }
    return data;
  }
}

class Item {
  String? sId;
  String? text;
  User? user;
  String? video;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Item(
      {this.sId,
        this.text,
        this.user,
        this.video,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Item.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    video = json['video'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['text'] = text;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['video'] = video;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class User {
  String? name;
  String? mobileNumber;
  String? email;
  String? dp;
  String? sId;
  String? username;

  User(
      {this.name,
        this.mobileNumber,
        this.email,
        this.dp,
        this.sId,
        this.username});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    dp = json['dp'];
    sId = json['_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mobileNumber'] = mobileNumber;
    data['email'] = email;
    data['dp'] = dp;
    data['_id'] = sId;
    data['username'] = username;
    return data;
  }
}
