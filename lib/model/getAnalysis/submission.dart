import 'package:flutter/cupertino.dart';

class GASubmission with ChangeNotifier {
  GAMeta? meta;
  GAResponse? response;
  bool? graded;
  bool? live;
  String? createdAt;
  String? sId;
  List<Roadmap>? roadmap;

  GASubmission(
      {this.meta,
        this.response,
        this.graded,
        this.live,
        this.createdAt,
        this.sId,
        this.roadmap});

  GASubmission.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new GAMeta.fromJson(json['meta']) : null;
    response = json['response'] != null
        ? new GAResponse.fromJson(json['response'])
        : null;
    graded = json['graded'];
    live = json['live'];
    createdAt = json['createdAt'];
    sId = json['_id'];
    if (json['roadmap'] != null) {
      roadmap = <Roadmap>[];
      json['roadmap'].forEach((v) {
        roadmap!.add(new Roadmap.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['graded'] = this.graded;
    data['live'] = this.live;
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    if (this.roadmap != null) {
      data['roadmap'] = this.roadmap!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GAMeta with ChangeNotifier {
  List<GASections>? sections;
  int? marks;
  int? questionsAttempted;
  int? correctQuestions;
  int? incorrectQuestions;
  dynamic correctTime;
  dynamic incorrectTime;
  dynamic unattemptedTime;
  dynamic precision;
  int? marksAttempted;
  int? marksGained;
  int? marksLost;
  GADifficulty? difficulty;
  dynamic percent;
  dynamic percentile;
  int? rank;
  dynamic firstSeenTime;
  int? firstSeenCorrect;
  int? firstSeenIncorrect;
  int? firstSeenSkip;

  GAMeta(
      {this.sections,
        this.marks,
        this.questionsAttempted,
        this.correctQuestions,
        this.incorrectQuestions,
        this.correctTime,
        this.incorrectTime,
        this.unattemptedTime,
        this.precision,
        this.marksAttempted,
        this.marksGained,
        this.marksLost,
        this.difficulty,
        this.percent,
        this.percentile,
        this.rank,
        this.firstSeenTime,
        this.firstSeenCorrect,
        this.firstSeenIncorrect,
        this.firstSeenSkip});

  GAMeta.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      sections = <GASections>[];
      json['sections'].forEach((v) {
        sections!.add(new GASections.fromJson(v));
      });
    }
    marks = json['marks'];
    questionsAttempted = json['questionsAttempted'];
    correctQuestions = json['correctQuestions'];
    incorrectQuestions = json['incorrectQuestions'];
    correctTime = json['correctTime'];
    incorrectTime = json['incorrectTime'];
    unattemptedTime = json['unattemptedTime'];
    precision = json['precision'];
    marksAttempted = json['marksAttempted'];
    marksGained = json['marksGained'];
    marksLost = json['marksLost'];
    difficulty = json['difficulty'] != null
        ? new GADifficulty.fromJson(json['difficulty'])
        : null;
    percent = json['percent'];
    percentile = json['percentile'];
    rank = json['rank'];
    firstSeenTime = json['firstSeenTime'];
    firstSeenCorrect = json['firstSeenCorrect'];
    firstSeenIncorrect = json['firstSeenIncorrect'];
    firstSeenSkip = json['firstSeenSkip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    data['marks'] = this.marks;
    data['questionsAttempted'] = this.questionsAttempted;
    data['correctQuestions'] = this.correctQuestions;
    data['incorrectQuestions'] = this.incorrectQuestions;
    data['correctTime'] = this.correctTime;
    data['incorrectTime'] = this.incorrectTime;
    data['unattemptedTime'] = this.unattemptedTime;
    data['precision'] = this.precision;
    data['marksAttempted'] = this.marksAttempted;
    data['marksGained'] = this.marksGained;
    data['marksLost'] = this.marksLost;
    if (this.difficulty != null) {
      data['difficulty'] = this.difficulty!.toJson();
    }
    data['percent'] = this.percent;
    data['percentile'] = this.percentile;
    data['rank'] = this.rank;
    data['firstSeenTime'] = this.firstSeenTime;
    data['firstSeenCorrect'] = this.firstSeenCorrect;
    data['firstSeenIncorrect'] = this.firstSeenIncorrect;
    data['firstSeenSkip'] = this.firstSeenSkip;
    return data;
  }
}

class GASections {
  dynamic nId;
  String? name;
  List<GASectionsQuestions>? questions;
  dynamic time;
  dynamic correctTime;
  dynamic incorrectTime;
  dynamic unattemptedTime;
  int? marks;
  int? marksAttempted;
  int? marksGained;
  int? marksLost;
  int? correct;
  int? incorrect;
  dynamic precision;

  GASections(
      {this.nId,
        this.name,
        this.questions,
        this.time,
        this.correctTime,
        this.incorrectTime,
        this.unattemptedTime,
        this.marks,
        this.marksAttempted,
        this.marksGained,
        this.marksLost,
        this.correct,
        this.incorrect,
        this.precision});

  GASections.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    name = json['name'];
    if (json['questions'] != null) {
      questions = <GASectionsQuestions>[];
      json['questions'].forEach((v) {
        questions!.add(new GASectionsQuestions.fromJson(v));
      });
    }
    time = json['time'];
    correctTime = json['correctTime'];
    incorrectTime = json['incorrectTime'];
    unattemptedTime = json['unattemptedTime'];
    marks = json['marks'];
    marksAttempted = json['marksAttempted'];
    marksGained = json['marksGained'];
    marksLost = json['marksLost'];
    correct = json['correct'];
    incorrect = json['incorrect'];
    precision = json['precision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.nId;
    data['name'] = this.name;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['time'] = this.time;
    data['correctTime'] = this.correctTime;
    data['incorrectTime'] = this.incorrectTime;
    data['unattemptedTime'] = this.unattemptedTime;
    data['marks'] = this.marks;
    data['marksAttempted'] = this.marksAttempted;
    data['marksGained'] = this.marksGained;
    data['marksLost'] = this.marksLost;
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['precision'] = this.precision;
    return data;
  }
}

class GASectionsQuestions {
  String? sId;
  dynamic answer;
  int? mark;
  dynamic time;
  int? correct;

  GASectionsQuestions({this.sId, this.answer, this.mark, this.time, this.correct});

  GASectionsQuestions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    answer = json['answer'];
    mark = json['mark'];
    time = json['time'];
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['answer'] = this.answer;
    data['mark'] = this.mark;
    data['time'] = this.time;
    data['correct'] = this.correct;
    return data;
  }
}

class GADifficulty {
  Easy? easy;
  Medium? medium;
  Easy? hard;

  GADifficulty({this.easy, this.medium, this.hard});

  GADifficulty.fromJson(Map<String, dynamic> json) {
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
  int? correct;
  int? incorrect;
  int? time;
  int? totalAttempts;

  Easy({this.correct, this.incorrect, this.time, this.totalAttempts});

  Easy.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    time = json['time'];
    totalAttempts = json['totalAttempts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['time'] = this.time;
    data['totalAttempts'] = this.totalAttempts;
    return data;
  }
}

class Medium {
  int? correct;
  int? incorrect;
  dynamic time;
  int? totalAttempts;

  Medium({this.correct, this.incorrect, this.time, this.totalAttempts});

  Medium.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    time = json['time'];
    totalAttempts = json['totalAttempts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['time'] = this.time;
    data['totalAttempts'] = this.totalAttempts;
    return data;
  }
}

class GAResponse {
  String? sId;
  List<ResponseSections>? sections;

  GAResponse({this.sId, this.sections});

  GAResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['sections'] != null) {
      sections = <ResponseSections>[];
      json['sections'].forEach((v) {
        sections!.add(new ResponseSections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseSections {
  String? name;
  int? totalQuestions;
  List<Questions>? questions;

  ResponseSections({this.name, this.totalQuestions, this.questions});

  ResponseSections.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalQuestions = json['total_questions'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_questions'] = this.totalQuestions;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? sId;
  dynamic time;
  dynamic answer;
  int? state;

  Questions({this.sId, this.time, this.answer, this.state});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    time = json['time'];
    answer = json['answer'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['time'] = this.time;
    data['answer'] = this.answer;
    data['state'] = this.state;
    return data;
  }
}

class Roadmap {
  dynamic firstVisit;
  String? sId;
  dynamic timeToughness;
  String? timeCategory;
  int? result;
  dynamic lastVisit;
  int? questionsSeen;
  int? questionsAttempted;
  dynamic time;
  dynamic totalTime;
  String? accuracy;
  String? sectionName;
  int? questionNo;
  int? totalVisits;
  int? difficulty;
  int? topic;

  Roadmap(
      {this.firstVisit,
        this.sId,
        this.timeToughness,
        this.timeCategory,
        this.result,
        this.lastVisit,
        this.questionsSeen,
        this.questionsAttempted,
        this.time,
        this.totalTime,
        this.accuracy,
        this.sectionName,
        this.questionNo,
        this.totalVisits,
        this.difficulty,
        this.topic});

  Roadmap.fromJson(Map<String, dynamic> json) {
    firstVisit = json['firstVisit'];
    sId = json['_id'];
    timeToughness = json['timeToughness'];
    timeCategory = json['timeCategory'];
    result = json['result'];
    lastVisit = json['lastVisit'];
    questionsSeen = json['questionsSeen'];
    questionsAttempted = json['questionsAttempted'];
    time = json['time'];
    totalTime = json['totalTime'];
    accuracy = json['accuracy'];
    sectionName = json['sectionName'];
    questionNo = json['questionNo'];
    totalVisits = json['totalVisits'];
    difficulty = json['difficulty'];
    topic = json['topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstVisit'] = this.firstVisit;
    data['_id'] = this.sId;
    data['timeToughness'] = this.timeToughness;
    data['timeCategory'] = this.timeCategory;
    data['result'] = this.result;
    data['lastVisit'] = this.lastVisit;
    data['questionsSeen'] = this.questionsSeen;
    data['questionsAttempted'] = this.questionsAttempted;
    data['time'] = this.time;
    data['totalTime'] = this.totalTime;
    data['accuracy'] = this.accuracy;
    data['sectionName'] = this.sectionName;
    data['questionNo'] = this.questionNo;
    data['totalVisits'] = this.totalVisits;
    data['difficulty'] = this.difficulty;
    data['topic'] = this.topic;
    return data;
  }
}
