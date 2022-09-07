class GetQuestionWithAnswers {
  Session? session;

  GetQuestionWithAnswers({this.session});

  GetQuestionWithAnswers.fromJson(Map<String, dynamic> json) {
    session = json['session'] != null ? new Session.fromJson(json['session']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.session != null) {
      data['session'] = this.session!.toJson();
    }
    return data;
  }
}

class Session {
  Note? note;
  Config? config;
  List<Null>? subtopics;
  bool? hasEnded;
  dynamic xpEarned;
  List<Null>? selectedQuestionsToAttempt;
  List<Null>? selectedQuestionsNotToAttempt;
  dynamic version;
  String? sId;
  String? user;
  List<Filters>? filters;
  String? startTime;
  String? title;
  List<Questions>? questions;
  String? createdAt;
  String? updatedAt;
  dynamic iV;
  List<Concepts>? concepts;

  Session({this.note, this.config, this.subtopics, this.hasEnded, this.xpEarned, this.selectedQuestionsToAttempt, this.selectedQuestionsNotToAttempt, this.version, this.sId, this.user, this.filters, this.startTime, this.title, this.questions, this.createdAt, this.updatedAt, this.iV, this.concepts});

  Session.fromJson(Map<String, dynamic> json) {
    note = json['note'] != null ? new Note.fromJson(json['note']) : null;
    config = json['config'] != null ? new Config.fromJson(json['config']) : null;
    if (json['subtopics'] != null) {
      subtopics = <Null>[];
     // json['subtopics'].forEach((v) { subtopics!.add(new Null.fromJson(v)); });
    }
    hasEnded = json['hasEnded'];
    xpEarned = json['xpEarned'];
    if (json['selectedQuestionsToAttempt'] != null) {
      selectedQuestionsToAttempt = <Null>[];
      //json['selectedQuestionsToAttempt'].forEach((v) { selectedQuestionsToAttempt!.add(new Null.fromJson(v)); });
    }
    if (json['selectedQuestionsNotToAttempt'] != null) {
      selectedQuestionsNotToAttempt = <Null>[];
      //json['selectedQuestionsNotToAttempt'].forEach((v) { selectedQuestionsNotToAttempt!.add(new Null.fromJson(v)); });
    }
    version = json['version'];
    sId = json['_id'];
    user = json['user'];
    if (json['filters'] != null) {
      filters = <Filters>[];
      json['filters'].forEach((v) { filters!.add(new Filters.fromJson(v)); });
    }
    startTime = json['startTime'];
    title = json['title'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) { questions!.add(new Questions.fromJson(v)); });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['concepts'] != null) {
      concepts = <Concepts>[];
      json['concepts'].forEach((v) { concepts!.add(new Concepts.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.note != null) {
      data['note'] = this.note!.toJson();
    }
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    if (this.subtopics != null) {
      //data['subtopics'] = this.subtopics!.map((v) => v.toJson()).toList();
    }
    data['hasEnded'] = this.hasEnded;
    data['xpEarned'] = this.xpEarned;
    if (this.selectedQuestionsToAttempt != null) {
      //data['selectedQuestionsToAttempt'] = this.selectedQuestionsToAttempt!.map((v) => v.toJson()).toList();
    }
    if (this.selectedQuestionsNotToAttempt != null) {
      //data['selectedQuestionsNotToAttempt'] = this.selectedQuestionsNotToAttempt!.map((v) => v.toJson()).toList();
    }
    data['version'] = this.version;
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.filters != null) {
      data['filters'] = this.filters!.map((v) => v.toJson()).toList();
    }
    data['startTime'] = this.startTime;
    data['title'] = this.title;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.concepts != null) {
      data['concepts'] = this.concepts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Note {
  String? type;
  String? data;

  Note({this.type, this.data});

  Note.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    return data;
  }
}

class Config {
  Questions? questions;
  Prevent? prevent;

  Config({this.questions, this.prevent});

  Config.fromJson(Map<String, dynamic> json) {
    questions = json['questions'] != null ? new Questions.fromJson(json['questions']) : null;
    prevent = json['prevent'] != null ? new Prevent.fromJson(json['prevent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.toJson();
    }
    if (this.prevent != null) {
      data['prevent'] = this.prevent!.toJson();
    }
    return data;
  }
}


class Prevent {
  bool? reattempt;
  bool? skip;

  Prevent({this.reattempt, this.skip});

  Prevent.fromJson(Map<String, dynamic> json) {
    reattempt = json['reattempt'];
    skip = json['skip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reattempt'] = this.reattempt;
    data['skip'] = this.skip;
    return data;
  }
}

class Filters {
  List<Null>? levels;
  String? sId;
  String? subTopic;

  Filters({this.levels, this.sId, this.subTopic});

  Filters.fromJson(Map<String, dynamic> json) {
    if (json['levels'] != null) {
      levels = <Null>[];
      //json['levels'].forEach((v) { levels!.add(new Null.fromJson(v)); });
    }
    sId = json['_id'];
    subTopic = json['subTopic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.levels != null) {
      //data['levels'] = this.levels!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['subTopic'] = this.subTopic;
    return data;
  }
}

class Questions {
  String? sId;
  String? question;
  dynamic level;
  String? subTopic;
  Attempt? attempt;

  Questions({this.sId, this.question, this.level, this.subTopic, this.attempt});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    level = json['level'];
    subTopic = json['subTopic'];
    attempt = json['attempt'] != null ? new Attempt.fromJson(json['attempt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['question'] = this.question;
    data['level'] = this.level;
    data['subTopic'] = this.subTopic;
    if (this.attempt != null) {
      data['attempt'] = this.attempt!.toJson();
    }
    return data;
  }
}


class PerfectTimeLimits {
  dynamic min;
  dynamic max;

  PerfectTimeLimits({this.min, this.max});

  PerfectTimeLimits.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}

class Flow {
  String? sId;
  String? startTime;
  String? endTime;

  Flow({this.sId, this.startTime, this.endTime});

  Flow.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}

class Concepts {
  String? sId;
  String? concept;

  Concepts({this.sId, this.concept});

  Concepts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    concept = json['concept'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['concept'] = this.concept;
    return data;
  }
}

class PreAttempetdQuestions {
  List<Questions>? questions;

  PreAttempetdQuestions({this.questions});

  PreAttempetdQuestions.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*class Questions {
  String? sId;
  String? question;
  dynamic level;
  String? subTopic;
  Attempt? attempt;

  Questions({this.sId, this.question, this.level, this.subTopic, this.attempt});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    level = json['level'];
    subTopic = json['subTopic'];
    attempt =
    json['attempt'] != null ? new Attempt.fromJson(json['attempt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['question'] = this.question;
    data['level'] = this.level;
    data['subTopic'] = this.subTopic;
    if (this.attempt != null) {
      data['attempt'] = this.attempt!.toJson();
    }
    return data;
  }
}*/

class Attempt {
  Answer? answer;
  PerfectTimeLimits? perfectTimeLimits;
  String? mode;
  dynamic batch;
  bool? isAnswered;
  dynamic time;
  dynamic xpEarned;
  dynamic version;
  String? sId;
  String? user;
  String? question;
  String? startTime;
  String? endTime;
  dynamic speed;
  bool? isCorrect;
  dynamic medianTime;
  dynamic demoRank;
  List<Flow>? flow;
  List<Null>? answerSelectionFlow;
  String? createdAt;
  String? updatedAt;
  dynamic iV;
  bool? isSkipped;

  Attempt(
      {this.answer,
        this.perfectTimeLimits,
        this.mode,
        this.batch,
        this.isAnswered,
        this.time,
        this.xpEarned,
        this.version,
        this.sId,
        this.user,
        this.question,
        this.startTime,
        this.endTime,
        this.speed,
        this.isCorrect,
        this.medianTime,
        this.demoRank,
        this.flow,
        this.answerSelectionFlow,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.isSkipped});

  Attempt.fromJson(Map<String, dynamic> json) {
    answer =
    json['answer'] != null ? new Answer.fromJson(json['answer']) : null;
    perfectTimeLimits = json['perfectTimeLimits'] != null
        ? new PerfectTimeLimits.fromJson(json['perfectTimeLimits'])
        : null;
    mode = json['mode'];
    batch = json['batch'];
    isAnswered = json['isAnswered'];
    time = json['time'];
    xpEarned = json['xpEarned'];
    version = json['version'];
    sId = json['_id'];
    user = json['user'];
    question = json['question'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    speed = json['speed'];
    isCorrect = json['isCorrect'];
    medianTime = json['medianTime'];
    demoRank = json['demoRank'];
    if (json['flow'] != null) {
      flow = <Flow>[];
      json['flow'].forEach((v) {
        flow!.add(new Flow.fromJson(v));
      });
    }
    if (json['answerSelectionFlow'] != null) {
      answerSelectionFlow = <Null>[];
      json['answerSelectionFlow'].forEach((v) {
       // answerSelectionFlow!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isSkipped = json['isSkipped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answer != null) {
      data['answer'] = this.answer!.toJson();
    }
    if (this.perfectTimeLimits != null) {
      data['perfectTimeLimits'] = this.perfectTimeLimits!.toJson();
    }
    data['mode'] = this.mode;
    data['batch'] = this.batch;
    data['isAnswered'] = this.isAnswered;
    data['time'] = this.time;
    data['xpEarned'] = this.xpEarned;
    data['version'] = this.version;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['question'] = this.question;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['speed'] = this.speed;
    data['isCorrect'] = this.isCorrect;
    data['medianTime'] = this.medianTime;
    data['demoRank'] = this.demoRank;
    if (this.flow != null) {
      data['flow'] = this.flow!.map((v) => v.toJson()).toList();
    }
    if (this.answerSelectionFlow != null) {
     // data['answerSelectionFlow'] =
          //this.answerSelectionFlow!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isSkipped'] = this.isSkipped;
    return data;
  }
}

class Answer {
  String? type;
  String? data;

  Answer({this.type, this.data});

  Answer.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    return data;
  }
}


