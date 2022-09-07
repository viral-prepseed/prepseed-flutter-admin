class GetCommentTest {
  String? sId;
  String? id;
  List<Threads>? threads;
  bool? solutionRequested;

  GetCommentTest({this.sId, this.id, this.threads, this.solutionRequested});

  GetCommentTest.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    if (json['threads'] != null) {
      threads = <Threads>[];
      json['threads'].forEach((v) {
        threads!.add(new Threads.fromJson(v));
      });
    }
    solutionRequested = json['solutionRequested'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    if (this.threads != null) {
      data['threads'] = this.threads!.map((v) => v.toJson()).toList();
    }
    data['solutionRequested'] = this.solutionRequested;
    return data;
  }
}

class Threads {
  String? sId;
  int? kind;
  String? text;
  List<String>? upvotes;
  List<Null>? downvotes;
  User? user;
  List<Null>? threads;

  Threads(
      {this.sId,
        this.kind,
        this.text,
        this.upvotes,
        this.downvotes,
        this.user,
        this.threads});

  Threads.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    kind = json['kind'];
    text = json['text'];
    upvotes = json['upvotes'].cast<String>();
    if (json['downvotes'] != null) {
      downvotes = <Null>[];
      json['downvotes'].forEach((v) {
      //  downvotes!.add(new Null.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['threads'] != null) {
      threads = <Null>[];
      json['threads'].forEach((v) {
        //threads!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['kind'] = this.kind;
    data['text'] = this.text;
    data['upvotes'] = this.upvotes;
    if (this.downvotes != null) {
    //  data['downvotes'] = this.downvotes!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.threads != null) {
    //  data['threads'] = this.threads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? dp;
  String? username;

  User({this.dp, this.username});

  User.fromJson(Map<String, dynamic> json) {
    dp = json['dp'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dp'] = this.dp;
    data['username'] = this.username;
    return data;
  }
}
