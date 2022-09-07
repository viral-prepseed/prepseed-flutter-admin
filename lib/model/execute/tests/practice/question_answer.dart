/*
class QuestionsAnswer {
  Question? question;
  int? currentTime;

  QuestionsAnswer({this.question, this.currentTime});

  QuestionsAnswer.fromJson(Map<String, dynamic> json) {
    question =
    json['question'] != null ? new Question.fromJson(json['question']) : null;
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

class Question {
  Core? core;
  SessionSpecific? sessionSpecific;

  Question({this.core, this.sessionSpecific});

  Question.fromJson(Map<String, dynamic> json) {
    core = json['core'] != null ? new Core.fromJson(json['core']) : null;
    sessionSpecific =
    json['sessionSpecific'] != null ? new SessionSpecific.fromJson(
        json['sessionSpecific']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.core != null) {
      data['core'] = this.core!.toJson();
    }
    if (this.sessionSpecific != null) {
      data['sessionSpecific'] = this.sessionSpecific!.toJson();
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
  Solution? solution;
  Solution? content;
  List<Options>? options;

  Core(
      {this.type, this.level, this.dataType, this.sId, this.topic, this.subTopic, this.concepts, this.solution, this.content, this.options});

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
    solution =
    json['solution'] != null ? new Solution.fromJson(json['solution']) : null;
    content =
    json['content'] != null ? new Solution.fromJson(json['content']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
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
    if (this.solution != null) {
      data['solution'] = this.solution!.toJson();
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

class Solution {
  RawContent? rawContent;

  Solution({this.rawContent});

  Solution.fromJson(Map<String, dynamic> json) {
    rawContent = json['rawContent'] != null
        ? new RawContent.fromJson(json['rawContent'])
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

class RawContent {
  List<Blocks>? blocks;
  EntityMap? entityMap;

  RawContent({this.blocks, this.entityMap});

  RawContent.fromJson(Map<String, dynamic> json) {
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
    if (this.entityMap != null) {
      data['entityMap'] = this.entityMap!.toJson();
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

  Blocks(
      {this.key, this.text, this.type, this.depth, this.inlineStyleRanges, this.entityRanges});

  Blocks.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    text = json['text'];
    type = json['type'];
    depth = json['depth'];
    if (json['inlineStyleRanges'] != null) {
      inlineStyleRanges = <Null>[];
      json['inlineStyleRanges'].forEach((v) {
        inlineStyleRanges!.add(new Null.fromJson(v));
      });
    }
    if (json['entityRanges'] != null) {
      entityRanges = <EntityRanges>[];
      json['entityRanges'].forEach((v) {
        entityRanges!.add(new EntityRanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['text'] = this.text;
    data['type'] = this.type;
    data['depth'] = this.depth;
    if (this.inlineStyleRanges != null) {
      data['inlineStyleRanges'] =
          this.inlineStyleRanges!.map((v) => v.toJson()).toList();
    }
    if (this.entityRanges != null) {
      data['entityRanges'] = this.entityRanges!.map((v) => v.toJson()).toList();
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

class EntityMap {
  Solve? solve;

  EntityMap

  ({this.00});

  EntityMap.fromJson(Map<String, dynamic> json) {
    00 = json['0'] != null ? new 0.fromJson(json['0']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.00 != null) {
      data['0'] = this.00!.toJson();
    }
    return data;
  }
}

class 0 {
String? type;
String? mutability;
Data? data;

0({this.type, this.mutability, this.data});

0.fromJson(Map<String, dynamic> json) {
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
String? url;

Data({this.url});

Data.fromJson(Map<String, dynamic> json) {
url = json['url'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['url'] = this.url;
return data;
}
}

class RawContent {
List<Blocks>? blocks;

RawContent({this.blocks});

RawContent.fromJson(Map<String, dynamic> json) {
if (json['blocks'] != null) {
blocks = <Blocks>[];
json['blocks'].forEach((v) { blocks!.add(new Blocks.fromJson(v)); });
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

class Blocks {
String? key;
String? text;
String? type;
int? depth;
List<Null>? inlineStyleRanges;
List<Null>? entityRanges;

Blocks({this.key, this.text, this.type, this.depth, this.inlineStyleRanges, this.entityRanges});

Blocks.fromJson(Map<String, dynamic> json) {
key = json['key'];
text = json['text'];
type = json['type'];
depth = json['depth'];
if (json['inlineStyleRanges'] != null) {
inlineStyleRanges = <Null>[];
json['inlineStyleRanges'].forEach((v) { inlineStyleRanges!.add(new Null.fromJson(v)); });
}
if (json['entityRanges'] != null) {
entityRanges = <Null>[];
json['entityRanges'].forEach((v) { entityRanges!.add(new Null.fromJson(v)); });
}
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['key'] = this.key;
data['text'] = this.text;
data['type'] = this.type;
data['depth'] = this.depth;
if (this.inlineStyleRanges != null) {
data['inlineStyleRanges'] = this.inlineStyleRanges!.map((v) => v.toJson()).toList();
}
if (this.entityRanges != null) {
data['entityRanges'] = this.entityRanges!.map((v) => v.toJson()).toList();
}
return data;
}
}

class Options {
String? sId;
bool? isCorrect;
Solution? content;

Options({this.sId, this.isCorrect, this.content});

Options.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
isCorrect = json['isCorrect'];
content = json['content'] != null ? new Solution.fromJson(json['content']) : null;
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['_id'] = this.sId;
data['isCorrect'] = this.isCorrect;
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

SessionSpecific({this.sId, this.question, this.level, this.subTopic, this.attempt});

SessionSpecific.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
question = json['question'] != null ? new Question.fromJson(json['question']) : null;
level = json['level'];
subTopic = json['subTopic'];
attempt = json['attempt'] != null ? new Attempt.fromJson(json['attempt']) : null;
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

class Question {
String? sId;
List<Concepts>? concepts;

Question({this.sId, this.concepts});

Question.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
if (json['concepts'] != null) {
concepts = <Concepts>[];
json['concepts'].forEach((v) { concepts!.add(new Concepts.fromJson(v)); });
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
int? medianTime;
int? demoRank;
List<Flow>? flow;
List<Null>? answerSelectionFlow;
String? createdAt;
String? updatedAt;
int? iV;
bool? isSkipped;

Attempt({this.answer, this.perfectTimeLimits, this.mode, this.batch, this.isAnswered, this.time, this.xpEarned, this.version, this.sId, this.user, this.question, this.startTime, this.endTime, this.speed, this.isCorrect, this.medianTime, this.demoRank, this.flow, this.answerSelectionFlow, this.createdAt, this.updatedAt, this.iV, this.isSkipped});

Attempt.fromJson(Map<String, dynamic> json) {
answer = json['answer'] != null ? new Answer.fromJson(json['answer']) : null;
perfectTimeLimits = json['perfectTimeLimits'] != null ? new PerfectTimeLimits.fromJson(json['perfectTimeLimits']) : null;
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
json['flow'].forEach((v) { flow!.add(new Flow.fromJson(v)); });
}
if (json['answerSelectionFlow'] != null) {
answerSelectionFlow = <Null>[];
json['answerSelectionFlow'].forEach((v) { answerSelectionFlow!.add(new Null.fromJson(v)); });
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
data['answerSelectionFlow'] = this.answerSelectionFlow!.map((v) => v.toJson()).toList();
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
double? min;
double? max;

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

class Core {
String? type;
int? level;
String? dataType;
String? sId;
String? topic;
String? subTopic;
List<Concepts>? concepts;
Solution? solution;
Solution? content;
List<Options>? options;

Core({this.type, this.level, this.dataType, this.sId, this.topic, this.subTopic, this.concepts, this.solution, this.content, this.options});

Core.fromJson(Map<String, dynamic> json) {
type = json['type'];
level = json['level'];
dataType = json['dataType'];
sId = json['_id'];
topic = json['topic'];
subTopic = json['sub_topic'];
if (json['concepts'] != null) {
concepts = <Concepts>[];
json['concepts'].forEach((v) { concepts!.add(new Concepts.fromJson(v)); });
}
solution = json['solution'] != null ? new Solution.fromJson(json['solution']) : null;
content = json['content'] != null ? new Solution.fromJson(json['content']) : null;
if (json['options'] != null) {
options = <Options>[];
json['options'].forEach((v) { options!.add(new Options.fromJson(v)); });
}
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
if (this.solution != null) {
data['solution'] = this.solution!.toJson();
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

class Options {
String? sId;
bool? isCorrect;
Solution? content;

Options({this.sId, this.isCorrect, this.content});

Options.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
isCorrect = json['isCorrect'];
content = json['content'] != null ? new Solution.fromJson(json['content']) : null;
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['_id'] = this.sId;
data['isCorrect'] = this.isCorrect;
if (this.content != null) {
data['content'] = this.content!.toJson();
}
return data;
}
}
*/
