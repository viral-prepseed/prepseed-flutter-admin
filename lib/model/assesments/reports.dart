import 'package:flutter/material.dart';

class Report with ChangeNotifier {
  List<Items>? items;

  Report({this.items});

  Report.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  User? user;
  User? topper;
  StatsBySectionUser? statsBySection;
  List<Details>? details;
  MaxMarks? maxMarks;

  Items(
      {this.user,
        this.topper,
        this.statsBySection,
        this.details,
        this.maxMarks});

  Items.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    topper = json['topper'] != null ? new User.fromJson(json['topper']) : null;
    statsBySection = json['statsBySection'] != null
        ? new StatsBySectionUser.fromJson(json['statsBySection'])
        : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    maxMarks = json['maxMarks'] != null
        ? new MaxMarks.fromJson(json['maxMarks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.topper != null) {
      data['topper'] = this.topper!.toJson();
    }
    if (this.statsBySection != null) {
      data['statsBySection'] = this.statsBySection!.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    if (this.maxMarks != null) {
      data['maxMarks'] = this.maxMarks!.toJson();
    }
    return data;
  }
}

class User {
  Overall? overall;
  Overall? physics;
  Overall? chemistry;
  Overall? mathematics;

  User({this.overall, this.physics, this.chemistry, this.mathematics});

  User.fromJson(Map<String, dynamic> json) {
    overall =
    json['overall'] != null ? new Overall.fromJson(json['overall']) : null;
    physics =
    json['physics'] != null ? new Overall.fromJson(json['physics']) : null;
    chemistry = json['chemistry'] != null
        ? new Overall.fromJson(json['chemistry'])
        : null;
    mathematics = json['mathematics'] != null
        ? new Overall.fromJson(json['mathematics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overall != null) {
      data['overall'] = this.overall!.toJson();
    }
    if (this.physics != null) {
      data['physics'] = this.physics!.toJson();
    }
    if (this.chemistry != null) {
      data['chemistry'] = this.chemistry!.toJson();
    }
    if (this.mathematics != null) {
      data['mathematics'] = this.mathematics!.toJson();
    }
    return data;
  }
}

class StatsBySectionUser {
  StatsBySectionOverall? overall;
  StatsBySectionOverall? physics;
  StatsBySectionOverall? chemistry;
  StatsBySectionOverall? mathematics;

  StatsBySectionUser({this.overall, this.physics, this.chemistry, this.mathematics});

  StatsBySectionUser.fromJson(Map<String, dynamic> json) {
    overall =
    json['overall'] != null ? new StatsBySectionOverall.fromJson(json['overall']) : null;
    physics =
    json['physics'] != null ? new StatsBySectionOverall.fromJson(json['physics']) : null;
    chemistry = json['chemistry'] != null
        ? new StatsBySectionOverall.fromJson(json['chemistry'])
        : null;
    mathematics = json['mathematics'] != null
        ? new StatsBySectionOverall.fromJson(json['mathematics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overall != null) {
      data['overall'] = this.overall!.toJson();
    }
    if (this.physics != null) {
      data['physics'] = this.physics!.toJson();
    }
    if (this.chemistry != null) {
      data['chemistry'] = this.chemistry!.toJson();
    }
    if (this.mathematics != null) {
      data['mathematics'] = this.mathematics!.toJson();
    }
    return data;
  }
}

class Overall {
  int? marks;

  Overall({this.marks});

  Overall.fromJson(Map<String, dynamic> json) {
    marks = json['marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marks'] = this.marks;
    return data;
  }
}

class StatsBySectionOverall {
  int? averageMarks;
  dynamic percentile;
  int? highestMarks;
  dynamic cumulativePercentile;

  StatsBySectionOverall(
      {this.averageMarks,
        this.percentile,
        this.highestMarks,
        this.cumulativePercentile});

  StatsBySectionOverall.fromJson(Map<String, dynamic> json) {
    averageMarks = json['averageMarks'];
    percentile = json['percentile'];
    highestMarks = json['highestMarks'];
    cumulativePercentile = json['cumulativePercentile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['averageMarks'] = this.averageMarks;
    data['percentile'] = this.percentile;
    data['highestMarks'] = this.highestMarks;
    data['cumulativePercentile'] = this.cumulativePercentile;
    return data;
  }
}

class Details {
  String? name;
  String? availableFrom;

  Details({this.name, this.availableFrom});

  Details.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    availableFrom = json['availableFrom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['availableFrom'] = this.availableFrom;
    return data;
  }
}

class MaxMarks {
  int? overall;
  int? physics;
  int? chemistry;
  int? mathematics;

  MaxMarks({this.overall, this.physics, this.chemistry, this.mathematics});

  MaxMarks.fromJson(Map<String, dynamic> json) {
    overall = json['overall'];
    physics = json['physics'];
    chemistry = json['chemistry'];
    mathematics = json['mathematics'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overall'] = this.overall;
    data['physics'] = this.physics;
    data['chemistry'] = this.chemistry;
    data['mathematics'] = this.mathematics;
    return data;
  }
}
