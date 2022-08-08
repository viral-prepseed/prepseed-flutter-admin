class videos_attendance {
  List<Items>? items;
  String? now;

  videos_attendance({this.items, this.now});

  videos_attendance.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    now = json['now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['now'] = this.now;
    return data;
  }
}

class Items {
  String? resourceModel;
  String? sId;
  String? availableFrom;
  Resource? resource;
  // List<Null>? tags;
  String? topic;
  String? subject;
  String? date;
  String? playlistId;
  dynamic availableTill;

  Items(
      {this.resourceModel,
        this.sId,
        this.availableFrom,
        this.resource,
        // this.tags,
        this.topic,
        this.subject,
        this.date,
        this.playlistId,
        this.availableTill});

  Items.fromJson(Map<String, dynamic> json) {
    resourceModel = json['resourceModel'];
    sId = json['_id'];
    availableFrom = json['availableFrom'];
    resource = json['resource'] != null
        ? new Resource.fromJson(json['resource'])
        : null;
/*    if (json['tags'] != null) {
      tags = <Null>[];
      json['tags'].forEach((v) {
        // tags!.add(new Null.fromJson(v));
      });
    }*/
    topic = json['topic'];
    subject = json['subject'];
    date = json['date'];
    playlistId = json['playlistId'];
    availableTill = json['availableTill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceModel'] = this.resourceModel;
    data['_id'] = this.sId;
    data['availableFrom'] = this.availableFrom;
    if (this.resource != null) {
      data['resource'] = this.resource!.toJson();
    }
/*    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }*/
    data['topic'] = this.topic;
    data['subject'] = this.subject;
    data['date'] = this.date;
    data['playlistId'] = this.playlistId;
    data['availableTill'] = this.availableTill;
    return data;
  }
}

class Resource {
  String? sId;
  String? title;
  List<Tags>? tags;
  int? maxMarks;
  String? id;

  Resource({this.sId, this.title, this.tags, this.maxMarks, this.id});

  Resource.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    maxMarks = json['maxMarks'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['maxMarks'] = this.maxMarks;
    data['id'] = this.id;
    return data;
  }
}

class Tags {
  String? sId;
  String? key;
  String? value;

  Tags({this.sId, this.key, this.value});

  Tags.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
