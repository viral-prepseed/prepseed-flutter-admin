class Group {
  bool? success;
  List<Groups>? groups;

  Group({this.success, this.groups});

  Group.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(new Groups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Groups {
  bool? isPremium;
  bool? isVisible;
  String? sId;
  String? name;
  List<Subgroups>? subgroups;
  List? leaderboard;
  List? labs;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Groups(
      {this.isPremium,
        this.isVisible,
        this.sId,
        this.name,
        this.subgroups,
        this.leaderboard,
        this.labs,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Groups.fromJson(Map<String, dynamic> json) {
    isPremium = json['isPremium'];
    isVisible = json['isVisible'];
    sId = json['_id'];
    name = json['name'];
    if (json['subgroups'] != null) {
      subgroups = <Subgroups>[];
      json['subgroups'].forEach((v) {
        subgroups!.add(new Subgroups.fromJson(v));
      });
    }
    if (json['leaderboard'] != null) {
      leaderboard = <Null>[];
      json['leaderboard'].forEach((v) {
        // leaderboard!.add(new Null.fromJson(v));
      });
    }
    if (json['labs'] != null) {
      labs = <Null>[];
      json['labs'].forEach((v) {
        // labs!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPremium'] = this.isPremium;
    data['isVisible'] = this.isVisible;
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.subgroups != null) {
      data['subgroups'] = this.subgroups!.map((v) => v.toJson()).toList();
    }
    if (this.leaderboard != null) {
      data['leaderboard'] = this.leaderboard!.map((v) => v.toJson()).toList();
    }
    if (this.labs != null) {
      data['labs'] = this.labs!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Subgroups {
  String? sId;
  Subgroup? subgroup;

  Subgroups({this.sId, this.subgroup});

  Subgroups.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subgroup = json['subgroup'] != null
        ? new Subgroup.fromJson(json['subgroup'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.subgroup != null) {
      data['subgroup'] = this.subgroup!.toJson();
    }
    return data;
  }
}

class Subgroup {
  String? sId;
  String? name;

  Subgroup({this.sId, this.name});

  Subgroup.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
