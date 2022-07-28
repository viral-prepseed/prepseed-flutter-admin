class AnnouncementModel {
  List<Items>? items;
  int? total;

  AnnouncementModel({this.items, this.total});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Items {
  List<String>? categories;
  bool? deleted;
  String? sId;
  List<VisibleTo>? visibleTo;
  List<Files>? files;
  String? body;
  String? title;
  CreatedBy? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Items(
      {this.categories,
        this.deleted,
        this.sId,
        this.visibleTo,
        this.files,
        this.body,
        this.title,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <String>[];
      json['categories'].forEach((v) {
        //categories!.add(new String.fromJson(v));
      });
    }
    deleted = json['deleted'];
    sId = json['_id'];
    if (json['visibleTo'] != null) {
      visibleTo = <VisibleTo>[];
      json['visibleTo'].forEach((v) {
        visibleTo!.add(new VisibleTo.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    body = json['body'];
    title = json['title'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      //data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['deleted'] = this.deleted;
    data['_id'] = this.sId;
    if (this.visibleTo != null) {
      data['visibleTo'] = this.visibleTo!.map((v) => v.toJson()).toList();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['body'] = this.body;
    data['title'] = this.title;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class VisibleTo {
  String? sId;
  String? value;
  String? type;

  VisibleTo({this.sId, this.value, this.type});

  VisibleTo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    value = json['value'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['value'] = this.value;
    data['type'] = this.type;
    return data;
  }
}

class Files {
  String? sId;
  String? name;
  String? type;
  String? extension;
  String? url;

  Files({this.sId, this.name, this.type, this.extension, this.url});

  Files.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    extension = json['extension'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['extension'] = this.extension;
    data['url'] = this.url;
    return data;
  }
}

class CreatedBy {
  String? dp;
  String? sId;
  String? name;
  String? username;

  CreatedBy({this.dp, this.sId, this.name, this.username});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    dp = json['dp'];
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dp'] = this.dp;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }
}