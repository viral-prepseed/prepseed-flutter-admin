import 'dart:convert';

import 'getanswer.dart';

class GetQuestion {
  MainQuestion? question;
  int? currentTime;

  GetQuestion({this.question, this.currentTime});

  GetQuestion.fromJson(Map<String, dynamic> json) {
    question = json['question'] != null
        ? new MainQuestion.fromJson(json['question'])
        : null;
    currentTime = json['currentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    data['currentTime'] = this.currentTime;
    return data;
  }
}

class MainQuestion {
  Core? core;
  SessionSpecific? sessionSpecific;

  MainQuestion({this.core, this.sessionSpecific});

  MainQuestion.fromJson(Map<String, dynamic> json) {
    core = json['core'] != null ? new Core.fromJson(json['core']) : null;
    sessionSpecific = json['sessionSpecific'] != null
        ? new SessionSpecific.fromJson(json['sessionSpecific'])
        : null;
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

class Core {
  String? type;
  int? level;
  String? dataType;
  String? sId;
  String? topic;
  String? subTopic;
  List<Concepts>? concepts;
  Content? content;
  List<Options>? options;
  Solution? solution;

  Core(
      {this.type,
        this.level,
        this.dataType,
        this.sId,
        this.topic,
        this.subTopic,
        this.concepts,
        this.content,
        this.options,
        this.solution});

  Core.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    level = json['level'];
    dataType = json['dataType'];
    sId = json['_id'];
    topic = json['topic'];
    subTopic = json['sub_topic'];
    if (json['concepts'] != null) {
      concepts = <Concepts>[];
      json['concepts'].forEach((v) {
        concepts!.add(new Concepts.fromJson(v));
      });
    }
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    solution = json["solution"] != null ? Solution.fromJson(json["solution"]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['level'] = this.level;
    data['dataType'] = this.dataType;
    data['_id'] = this.sId;
    data['topic'] = this.topic;
    data['sub_topic'] = this.subTopic;
    if (this.concepts != null) {
      data['concepts'] = this.concepts!.map((v) => v.toJson()).toList();
    }
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
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

class Content {
  RawContent? rawContent;

  Content({this.rawContent});

  Content.fromJson(Map<String, dynamic> _json) {
    if(_json['rawContent'].runtimeType == String &&  _json['rawContent'] != null){
      rawContent = RawContent.fromJson(json.decode(_json['rawContent']));
    }
    else {
      rawContent = _json['rawContent'] != null
          ? RawContent.fromJson(_json['rawContent'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rawContent != null) {
      data['rawContent'] = this.rawContent!.toJson();
    }
    return data;
  }
}

class RawContent {
  List<Blocks>? blocks;
  List<EntityMap>? entityMap;
  RawContent({this.blocks, this.entityMap});

  RawContent.fromJson(Map<String, dynamic> json) {
    if (json['blocks'] != null) {
      blocks = <Blocks>[];
      json['blocks'].forEach((v) {
        blocks!.add(new Blocks.fromJson(v));
      });
    }
    if (json['entityMap'] != null) {
      entityMap = <EntityMap>[];
      json['entityMap'].values.forEach((v) {
        entityMap!.add(new EntityMap.fromJson(v));
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
/*class EntityMap {
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
}*/
/*

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
*/

class EntityMap {
  String? type;
  String? mutability;
  Data? data;

  EntityMap({this.type, this.mutability, this.data});

  EntityMap.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    mutability = json['mutability'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  dynamic url;
  String? content;
  Data({this.url,this.content});

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['content'] = content;
    return data;
  }
}


class Blocks {
  String? key;
  String? text;
  String? type;
  int? depth;
  List<Null>? inlineStyleRanges;
  List<Null>? entityRanges;

  Blocks(
      {this.key,
        this.text,
        this.type,
        this.depth,
        this.inlineStyleRanges,
        this.entityRanges});

  Blocks.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    text = json['text'];
    type = json['type'];
    depth = json['depth'];
    if (json['inlineStyleRanges'] != null) {
      inlineStyleRanges = <Null>[];
      /*json['inlineStyleRanges'].forEach((v) {
        inlineStyleRanges!.add(new Null.fromJson(v));
      });*/
    }
    if (json['entityRanges'] != null) {
      entityRanges = <Null>[];
     /* json['entityRanges'].forEach((v) {
        entityRanges!.add(Null.fromJson(v));
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
      /*data['inlineStyleRanges'] =
          this.inlineStyleRanges!.map((v) => v.toJson()).toList();*/
    }
    if (this.entityRanges != null) {
      /*data['entityRanges'] = this.entityRanges!.map((v) => v.toJson()).toList();*/
    }
    return data;
  }
}

class Options {
  String? sId;
  bool? isCorrect;
  Content? content;

  Options({this.sId, this.isCorrect, this.content});

  Options.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isCorrect =
    json['isCorrect'] != null ? json['isCorrect'] : null;
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
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
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
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

class Questions {
  String? sId;
  List<Concepts>? concepts;

  Questions({this.sId, this.concepts});

  Questions.fromJson(Map<String, dynamic> json) {
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
class Attempt {
  Answer? answer;
  PerfectTimeLimits? perfectTimeLimits;
  String? mode;
  dynamic batch;
  bool? isAnswered;
  int? time;
  int? xpEarned;
  int? version;
  String? sId;
  String? user;
  String? question;
  String? startTime;
  dynamic endTime;
  dynamic speed;
  dynamic isCorrect;
  dynamic medianTime;
  int? demoRank;
  List<Flow>? flow;
  List<Null>? answerSelectionFlow;
  String? createdAt;
  String? updatedAt;
  int? iV;

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
        this.iV});

  Attempt.fromJson(Map<String, dynamic> json) {
    perfectTimeLimits = json['perfectTimeLimits'] != null
        ? new PerfectTimeLimits.fromJson(json['perfectTimeLimits'])
        : null;
    answer = json['answer'] != null
        ? new Answer.fromJson(json['answer'])
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
     /* json['answerSelectionFlow'].forEach((v) {
        answerSelectionFlow!.add(new Null.fromJson(v));
      });*/
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  Flow({this.sId, this.startTime});

  Flow.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['startTime'] = this.startTime;
    return data;
  }
}
