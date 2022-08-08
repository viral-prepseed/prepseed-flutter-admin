class PhaseLeaderboard {
  bool? success;
  List<Leaderboard>? leaderboard;

  PhaseLeaderboard({this.success, this.leaderboard});

  PhaseLeaderboard.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['leaderboard'] != null) {
      leaderboard = <Leaderboard>[];
      json['leaderboard'].forEach((v) {
        leaderboard!.add(new Leaderboard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.leaderboard != null) {
      data['leaderboard'] = this.leaderboard!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leaderboard {
  dynamic rating;
  String? sId;
  User? user;
  String? lastUpdated;

  Leaderboard({this.rating, this.sId, this.user, this.lastUpdated});

  Leaderboard.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}

class User {
  String? dp;
  String? sId;
  String? username;

  User({this.dp, this.sId, this.username});

  User.fromJson(Map<String, dynamic> json) {
    dp = json['dp'];
    sId = json['_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dp'] = this.dp;
    data['_id'] = this.sId;
    data['username'] = this.username;
    return data;
  }
}
