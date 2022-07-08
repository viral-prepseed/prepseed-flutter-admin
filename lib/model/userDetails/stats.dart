class UserStats {
  List<US_Topics>? topics;
  List? rating;
  List? dailyActivity;
  US_Difficulty? difficulty;
  TestPerformance? testPerformance;

  UserStats(
      {this.topics,
        this.rating,
        this.dailyActivity,
        this.difficulty,
        this.testPerformance});

  UserStats.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = <US_Topics>[];
      json['topics'].forEach((v) {
        topics!.add(new US_Topics.fromJson(v));
      });
    }
    if (json['rating'] != null) {
      rating = <Null>[];
      json['rating'].forEach((v) {
        // rating!.add(new Null.fromJson(v));
      });
    }
    if (json['daily_activity'] != null) {
      dailyActivity = <Null>[];
      json['daily_activity'].forEach((v) {
        // dailyActivity!.add(new Null.fromJson(v));
      });
    }
    difficulty = json['difficulty'] != null
        ? new US_Difficulty.fromJson(json['difficulty'])
        : null;
    testPerformance = json['test_performance'] != null
        ? new TestPerformance.fromJson(json['test_performance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    if (this.rating != null) {
      data['rating'] = this.rating!.map((v) => v.toJson()).toList();
    }
    if (this.dailyActivity != null) {
      data['daily_activity'] =
          this.dailyActivity!.map((v) => v.toJson()).toList();
    }
    if (this.difficulty != null) {
      data['difficulty'] = this.difficulty!.toJson();
    }
    if (this.testPerformance != null) {
      data['test_performance'] = this.testPerformance!.toJson();
    }
    return data;
  }
}

class US_Topics {
  String? id;
  int? percentComplete;
  LastActivity? lastActivity;
  TestPerformance? testPerformance;

  US_Topics(
      {this.id, this.percentComplete, this.lastActivity, this.testPerformance});

  US_Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    percentComplete = json['percent_complete'];
    lastActivity = json['last_activity'] != null
        ? new LastActivity.fromJson(json['last_activity'])
        : null;
    testPerformance = json['test_performance'] != null
        ? new TestPerformance.fromJson(json['test_performance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['percent_complete'] = this.percentComplete;
    if (this.lastActivity != null) {
      data['last_activity'] = this.lastActivity!.toJson();
    }
    if (this.testPerformance != null) {
      data['test_performance'] = this.testPerformance!.toJson();
    }
    return data;
  }
}

class LastActivity {
  String? subTopic;

  LastActivity({this.subTopic});

  LastActivity.fromJson(Map<String, dynamic> json) {
    subTopic = json['sub_topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_topic'] = this.subTopic;
    return data;
  }
}

class TestPerformance {
  int? correct;
  int? incorrect;
  int? unattempted;
  dynamic correctTime;
  dynamic incorrectTime;
  dynamic unattemptedTime;

  TestPerformance(
      {this.correct,
        this.incorrect,
        this.unattempted,
        this.correctTime,
        this.incorrectTime,
        this.unattemptedTime});

  TestPerformance.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    unattempted = json['unattempted'];
    correctTime = json['correctTime'];
    incorrectTime = json['incorrectTime'];
    unattemptedTime = json['unattemptedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['unattempted'] = this.unattempted;
    data['correctTime'] = this.correctTime;
    data['incorrectTime'] = this.incorrectTime;
    data['unattemptedTime'] = this.unattemptedTime;
    return data;
  }
}

class US_Difficulty {
  int? easy;
  int? medium;
  int? hard;

  US_Difficulty({this.easy, this.medium, this.hard});

  US_Difficulty.fromJson(Map<String, dynamic> json) {
    easy = json['Easy'];
    medium = json['Medium'];
    hard = json['Hard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Easy'] = this.easy;
    data['Medium'] = this.medium;
    data['Hard'] = this.hard;
    return data;
  }
}
