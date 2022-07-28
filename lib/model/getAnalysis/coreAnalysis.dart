class GACoreAnalysis {
  String? sId;
  Difficulty? difficulty;
  List<Marks>? marks;
  List<int>? hist;
  dynamic maxMarks;
  dynamic sumMarks;
  dynamic sumAccuracy;
  dynamic sumSqAccuracy;
  dynamic sumPickingAbility;
  dynamic sumSqPickingAbility;
  dynamic totalAttempts;
  List<Sections>? sections;
  dynamic nintypercentile;

  GACoreAnalysis(
      {this.sId,
        this.difficulty,
        this.marks,
        this.hist,
        this.maxMarks,
        this.sumMarks,
        this.sumAccuracy,
        this.sumSqAccuracy,
        this.sumPickingAbility,
        this.sumSqPickingAbility,
        this.totalAttempts,
        this.sections,
        this.nintypercentile});

  GACoreAnalysis.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    difficulty = json['difficulty'] != null
        ? new Difficulty.fromJson(json['difficulty'])
        : null;
    if (json['marks'] != null) {
      marks = <Marks>[];
      json['marks'].forEach((v) {
        marks!.add(new Marks.fromJson(v));
      });
    }
    hist = json['hist'].cast<int>();
    maxMarks = json['maxMarks'];
    sumMarks = json['sumMarks'];
    sumAccuracy = json['sumAccuracy'];
    sumSqAccuracy = json['sumSqAccuracy'];
    sumPickingAbility = json['sumPickingAbility'];
    sumSqPickingAbility = json['sumSqPickingAbility'];
    totalAttempts = json['totalAttempts'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
    nintypercentile = json['nintypercentile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.difficulty != null) {
      data['difficulty'] = this.difficulty!.toJson();
    }
    if (this.marks != null) {
      data['marks'] = this.marks!.map((v) => v.toJson()).toList();
    }
    data['hist'] = this.hist;
    data['maxMarks'] = this.maxMarks;
    data['sumMarks'] = this.sumMarks;
    data['sumAccuracy'] = this.sumAccuracy;
    data['sumSqAccuracy'] = this.sumSqAccuracy;
    data['sumPickingAbility'] = this.sumPickingAbility;
    data['sumSqPickingAbility'] = this.sumSqPickingAbility;
    data['totalAttempts'] = this.totalAttempts;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    data['nintypercentile'] = this.nintypercentile;
    return data;
  }
}

class Difficulty {
  Easy? easy;
  Medium? medium;
  Easy? hard;

  Difficulty({this.easy, this.medium, this.hard});

  Difficulty.fromJson(Map<String, dynamic> json) {
    easy = json['easy'] != null ? new Easy.fromJson(json['easy']) : null;
    medium =
    json['medium'] != null ? new Medium.fromJson(json['medium']) : null;
    hard = json['hard'] != null ? new Easy.fromJson(json['hard']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.easy != null) {
      data['easy'] = this.easy!.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium!.toJson();
    }
    if (this.hard != null) {
      data['hard'] = this.hard!.toJson();
    }
    return data;
  }
}

class Easy {
  dynamic correct;
  dynamic incorrect;
  dynamic time;
  dynamic totalAttempts;
  dynamic meanTime;

  Easy(
      {this.correct,
        this.incorrect,
        this.time,
        this.totalAttempts,
        this.meanTime});

  Easy.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    time = json['time'];
    totalAttempts = json['totalAttempts'];
    meanTime = json['meanTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['time'] = this.time;
    data['totalAttempts'] = this.totalAttempts;
    data['meanTime'] = this.meanTime;
    return data;
  }
}

class Medium {
  dynamic correct;
  dynamic incorrect;
  dynamic time;
  dynamic totalAttempts;
  dynamic meanTime;

  Medium(
      {this.correct,
        this.incorrect,
        this.time,
        this.totalAttempts,
        this.meanTime});

  Medium.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    time = json['time'];
    totalAttempts = json['totalAttempts'];
    meanTime = json['meanTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['time'] = this.time;
    data['totalAttempts'] = this.totalAttempts;
    data['meanTime'] = this.meanTime;
    return data;
  }
}

class Marks {
  String? sId;
  dynamic marks;
  String? user;

  Marks({this.sId, this.marks, this.user});

  Marks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    marks = json['marks'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['marks'] = this.marks;
    data['user'] = this.user;
    return data;
  }
}

class Sections {
  dynamic incorrect;
  dynamic correct;
  dynamic sumMarks;
  dynamic maxMarks;
  List<int>? marks;
  dynamic sumTime;
  dynamic meanTime;
  List<int>? hist;
  List<Questions>? questions;

  Sections(
      {this.incorrect,
        this.correct,
        this.sumMarks,
        this.maxMarks,
        this.marks,
        this.sumTime,
        this.meanTime,
        this.hist,
        this.questions});

  Sections.fromJson(Map<String, dynamic> json) {
    incorrect = json['incorrect'];
    correct = json['correct'];
    sumMarks = json['sumMarks'];
    maxMarks = json['maxMarks'];
    marks = json['marks'].cast<int>();
    sumTime = json['sumTime'];
    meanTime = json['meanTime'];
    hist = json['hist'].cast<int>();
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['incorrect'] = this.incorrect;
    data['correct'] = this.correct;
    data['sumMarks'] = this.sumMarks;
    data['maxMarks'] = this.maxMarks;
    data['marks'] = this.marks;
    data['sumTime'] = this.sumTime;
    data['meanTime'] = this.meanTime;
    data['hist'] = this.hist;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? id;
  dynamic sumTime;
  dynamic sumSqTime;
  dynamic correctAttempts;
  dynamic totalAttempts;
  dynamic meanTime;

  Questions(
      {this.id,
        this.sumTime,
        this.sumSqTime,
        this.correctAttempts,
        this.totalAttempts,
        this.meanTime});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sumTime = json['sumTime'];
    sumSqTime = json['sumSqTime'];
    correctAttempts = json['correctAttempts'];
    totalAttempts = json['totalAttempts'];
    meanTime = json['meanTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sumTime'] = this.sumTime;
    data['sumSqTime'] = this.sumSqTime;
    data['correctAttempts'] = this.correctAttempts;
    data['totalAttempts'] = this.totalAttempts;
    data['meanTime'] = this.meanTime;
    return data;
  }
}
