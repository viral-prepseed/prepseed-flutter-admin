class GetAnswer {
  int? xpEarned;
  String? message;
  Question? question;
  int? currentTime;

  GetAnswer({this.xpEarned, this.message, this.question, this.currentTime});

  GetAnswer.fromJson(Map<String, dynamic> json) {
    xpEarned = json['xpEarned'];
    message = json['message'];
    question =
    json['question'] != null ? new Question.fromJson(json['question']) : null;
    currentTime = json['currentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xpEarned'] = this.xpEarned;
    data['message'] = this.message;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    data['currentTime'] = this.currentTime;
    return data;
  }
}

class Question {
  Cores? core;
  SessionSpecific? sessionSpecific;

  Question({this.core, this.sessionSpecific});

  Question.fromJson(Map<String, dynamic> json) {
    core = json['core'] != null ?  Cores.fromJson(json['core']) : null;
    sessionSpecific =
    json['sessionSpecific'] != null ?  SessionSpecific.fromJson(json['sessionSpecific']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (core != null) {
      data['core'] = core!.toJson();
    }
    if (sessionSpecific != null) {
      data['sessionSpecific'] = sessionSpecific!.toJson();
    }
    return data;
  }
}

class Cores {
  Solution? solution;
  List<OptionsAnswers>? options;

  Cores({this.solution, this.options});

  Cores.fromJson(Map<String, dynamic> json) {
    solution =
    json['solution'] != null ? new Solution.fromJson(json['solution']) : null;
    if (json['options'] != null) {
      options = <OptionsAnswers>[];
      json['options'].forEach((v) {
        options!.add(new OptionsAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.solution != null) {
      data['solution'] = this.solution!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Solution {
  RawContents? rawContent;

  Solution({this.rawContent});

  Solution.fromJson(Map<String, dynamic> json) {
    rawContent = json['rawContent'] != null
        ? new RawContents.fromJson(json['rawContent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rawContent != null) {
      data['rawContent'] = this.rawContent!.toJson();
    }
    return data;
  }
}

class RawContents {
  List<Blocks>? blocks;
  EntityMap? entityMap;

  RawContents({this.blocks, this.entityMap});

  RawContents.fromJson(Map<String, dynamic> json) {
    if (json['blocks'] != null) {
      blocks = <Blocks>[];
      json['blocks'].forEach((v) {
        blocks!.add(new Blocks.fromJson(v));
      });
    }
    entityMap = json['entityMap'] != null
        ? new EntityMap.fromJson(json['entityMap'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blocks != null) {
      data['blocks'] = this.blocks!.map((v) => v.toJson()).toList();
    }
    if (entityMap != null) {
      data['entityMap'] = entityMap!.toJson();
    }
    return data;
  }
}

class Blocks {
  String? key;
  String? text;
  String? type;
  int? depth;
  List<Null>? inlineStyleRanges;
  List<EntityRanges>? entityRanges;
  /*Data? data;*/

  Blocks(
      {this.key, this.text, this.type, this.depth, this.inlineStyleRanges, this.entityRanges,/* this.data*/});

  Blocks.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    text = json['text'];
    type = json['type'];
    depth = json['depth'];
    if (json['inlineStyleRanges'] != null) {
      inlineStyleRanges = <Null>[];
     /* json['inlineStyleRanges'].forEach((v) {
        inlineStyleRanges!.add(new Null.fromJson(v));
      });*/
    }
    if (json['entityRanges'] != null) {
      entityRanges = <EntityRanges>[];
      json['entityRanges'].forEach((v) {
        entityRanges!.add(new EntityRanges.fromJson(v));
      });
    }
   /* data = json['data'] != null ? new Data.fromJson(json['data']) : null;*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['text'] = this.text;
    data['type'] = this.type;
    data['depth'] = this.depth;
    if (this.inlineStyleRanges != null) {
     /* data['inlineStyleRanges'] =
          this.inlineStyleRanges!.map((v) => v.toJson()).toList();*/
    }
    if (this.entityRanges != null) {
    /*  data['entityRanges'] = this.entityRanges!.map((v) => v.toJson()).toList();*/
    }
    if (data != null) {
    /*  data['data'] = data.toJson();*/
    }
    return data;
  }
}

class EntityRanges {
  int? offset;
  int? length;
  int? key;

  EntityRanges({this.offset, this.length, this.key});

  EntityRanges.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    length = json['length'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['length'] = this.length;
    data['key'] = this.key;
    return data;
  }
}

/*
class Data {

  Data.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
*/

class EntityMap {
  Solve? solve;

  EntityMap({this.solve});

  EntityMap.fromJson(Map<String, dynamic> json) {
    solve = json['0'] != null ? new Solve.fromJson(json['0']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.solve != null) {
      data['0'] = this.solve!.toJson();
    }
    return data;
  }
}

class Solve {
  String? type;
  String? mutability;
  DataUrl? data;

  Solve({this.type, this.mutability, this.data});

  Solve.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    mutability = json['mutability'];
    data = json['data'] != null ? new DataUrl.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['mutability'] = this.mutability;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataUrl {
  String? url;

  DataUrl({this.url});

  DataUrl.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class OptionsAnswers {
  bool? isAlternateCorrect;
  int? votes;
  String? sId;
  bool? isCorrect;
  Solution? content;

  OptionsAnswers(
      {this.isAlternateCorrect, this.votes, this.sId, this.isCorrect, this.content});

  OptionsAnswers.fromJson(Map<String, dynamic> json) {
    isAlternateCorrect = json['isAlternateCorrect'];
    votes = json['votes'];
    sId = json['_id'];
    isCorrect = json['isCorrect'];
    content =
    json['content'] != null ? new Solution.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAlternateCorrect'] = this.isAlternateCorrect;
    data['votes'] = this.votes;
    data['_id'] = this.sId;
    data['isCorrect'] = this.isCorrect;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class RawContentOptions {
  List<Blocks>? blocks;

  RawContentOptions({this.blocks});

  RawContentOptions.fromJson(Map<String, dynamic> json) {
    if (json['blocks'] != null) {
      blocks = <Blocks>[];
      json['blocks'].forEach((v) {
        blocks!.add(new Blocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blocks != null) {
      data['blocks'] = this.blocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlocksOptions {
  String? key;
  String? text;
  String? type;
  int? depth;
  List<Null>? inlineStyleRanges;
  List<Null>? entityRanges;

  BlocksOptions(
      {this.key, this.text, this.type, this.depth, this.inlineStyleRanges, this.entityRanges});

  BlocksOptions.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    text = json['text'];
    type = json['type'];
    depth = json['depth'];
    if (json['inlineStyleRanges'] != null) {
      inlineStyleRanges = <Null>[];
     /* json['inlineStyleRanges'].forEach((v) {
        inlineStyleRanges!.add(new Null.fromJson(v));
      });*/
    }
    if (json['entityRanges'] != null) {
      entityRanges = <Null>[];
     /* json['entityRanges'].forEach((v) {
        entityRanges!.add(new Null.fromJson(v));
      });*/
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['text'] = this.text;
    data['type'] = this.type;
    data['depth'] = this.depth;
    if (this.inlineStyleRanges != null) {
     /* data['inlineStyleRanges'] =
          this.inlineStyleRanges!.map((v) => v.toJson()).toList();*/
    }
    if (this.entityRanges != null) {
    /*  data['entityRanges'] = this.entityRanges!.map((v) => v.toJson()).toList();*/
    }
    return data;
  }
}

class SessionSpecific {
  String? sId;
  Question? question;
  int? level;
  String? subTopic;
  Attempt? attempt;

  SessionSpecific(
      {this.sId, this.question, this.level, this.subTopic, this.attempt});

  SessionSpecific.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question =
    json['question'] != null ? new Question.fromJson(json['question']) : null;
    level = json['level'];
    subTopic = json['subTopic'];
    attempt =
    json['attempt'] != null ? new Attempt.fromJson(json['attempt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    data['level'] = this.level;
    data['subTopic'] = this.subTopic;
    if (this.attempt != null) {
      data['attempt'] = this.attempt!.toJson();
    }
    return data;
  }
}

class QuestionId {
  String? sId;
  List<Concepts>? concepts;

  QuestionId({this.sId, this.concepts});

  QuestionId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['concepts'] != null) {
      concepts = <Concepts>[];
      json['concepts'].forEach((v) {
        concepts!.add(new Concepts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.concepts != null) {
      data['concepts'] = this.concepts!.map((v) => v.toJson()).toList();
    }
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

class Attempt {
  Answer? answer;
  PerfectTimeLimits? perfectTimeLimits;
  String? mode;
  int? batch;
  bool? isAnswered;
  int? time;
  int? xpEarned;
  int? version;
  String? sId;
  String? user;
  String? question;
  String? startTime;
  String? endTime;
  int? speed;
  bool? isCorrect;
  dynamic medianTime;
  int? demoRank;
  List<Flow>? flow;
  List<Null>? answerSelectionFlow;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isSkipped;

  Attempt(
      {this.answer, this.perfectTimeLimits, this.mode, this.batch, this.isAnswered, this.time, this.xpEarned, this.version, this.sId, this.user, this.question, this.startTime, this.endTime, this.speed, this.isCorrect, this.medianTime, this.demoRank, this.flow, this.answerSelectionFlow, this.createdAt, this.updatedAt, this.iV, this.isSkipped});

  Attempt.fromJson(Map<String, dynamic> json) {
    answer =
    json['answer'] != null ? new Answer.fromJson(json['answer']) : null;
    perfectTimeLimits =
    json['perfectTimeLimits'] != null ? new PerfectTimeLimits.fromJson(
        json['perfectTimeLimits']) : null;
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
      /*json['answerSelectionFlow'].forEach((v) {
        answerSelectionFlow!.add(new Null.fromJson(v));
      });*/
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
     /* data['answerSelectionFlow'] =
          this.answerSelectionFlow!.map((v) => v.toJson()).toList();*/
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

/*class Options {
  bool? isAlternateCorrect;
  int? votes;
  String? sId;
  bool? isCorrect;
  Solution? content;

  Options(
      {this.isAlternateCorrect, this.votes, this.sId, this.isCorrect, this.content});

  Options.fromJson(Map<String, dynamic> json) {
    isAlternateCorrect = json['isAlternateCorrect'];
    votes = json['votes'];
    sId = json['_id'];
    isCorrect = json['isCorrect'];
    content =
    json['content'] != null ? new Solution.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAlternateCorrect'] = this.isAlternateCorrect;
    data['votes'] = this.votes;
    data['_id'] = this.sId;
    data['isCorrect'] = this.isCorrect;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}*/
