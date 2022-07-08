import 'package:flutter/material.dart';

class Analysis with ChangeNotifier{
  bool? success;
  Submission? submission;
  CoreAnalysis_main? coreAnalysis;

  Analysis({this.success, this.submission, this.coreAnalysis});

  Analysis.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    submission = json['submission'] != null
        ? new Submission.fromJson(json['submission'])
        : null;
    coreAnalysis = json['coreAnalysis'] != null
        ? new CoreAnalysis_main.fromJson(json['coreAnalysis'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.submission != null) {
      data['submission'] = this.submission!.toJson();
    }
    if (this.coreAnalysis != null) {
      data['coreAnalysis'] = this.coreAnalysis!.toJson();
    }
    return data;
  }
}

class Submission with ChangeNotifier{
  List<Flow>? flow;
  bool? graded;
  bool? live;
  bool? isCategorized;
  dynamic version;
  bool? attemptsUpdated;
  bool? ignore;
  String? sEvent;
  String? sId;
  List? messages;
  String? assessmentWrapper;
  AssessmentCore? assessmentCore;
  WrapperAnalysis? wrapperAnalysis;
  // CoreAnalysis? coreAnalysis;
  String? user;
  Response? response;
  Response? originalResponse;
  String? createdAt;
  String? updatedAt;
  dynamic iV;
  Meta? meta;

  Submission(
      {this.flow,
        this.graded,
        this.live,
        this.isCategorized,
        this.version,
        this.attemptsUpdated,
        this.ignore,
        this.sEvent,
        this.sId,
        this.messages,
        this.assessmentWrapper,
        this.assessmentCore,
        this.wrapperAnalysis,
        // this.coreAnalysis,
        this.user,
        this.response,
        this.originalResponse,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.meta});

  Submission.fromJson(Map<String, dynamic> json) {
    if (json['flow'] != null) {
      flow = <Flow>[];
      json['flow'].forEach((v) {
        flow!.add(new Flow.fromJson(v));
      });
    }
    graded = json['graded'];
    live = json['live'];
    isCategorized = json['isCategorized'];
    version = json['version'];
    attemptsUpdated = json['attemptsUpdated'];
    ignore = json['ignore'];
    sEvent = json['sEvent'];
    sId = json['_id'];
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        //messages!.add(new Null.fromJson(v));
      });
    }
    assessmentWrapper = json['assessmentWrapper'];
    assessmentCore = json['assessmentCore'] != null
        ? new AssessmentCore.fromJson(json['assessmentCore'])
        : null;
    wrapperAnalysis = json['wrapperAnalysis'] != null
        ? new WrapperAnalysis.fromJson(json['wrapperAnalysis'])
        : null;
    /*coreAnalysis = json['coreAnalysis'] != null
        ? new CoreAnalysis.fromJson(json['coreAnalysis'])
        : null;*/
    user = json['user'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    originalResponse = json['originalResponse'] != null
        ? new Response.fromJson(json['originalResponse'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flow != null) {
      data['flow'] = this.flow!.map((v) => v.toJson()).toList();
    }
    data['graded'] = this.graded;
    data['live'] = this.live;
    data['isCategorized'] = this.isCategorized;
    data['version'] = this.version;
    data['attemptsUpdated'] = this.attemptsUpdated;
    data['ignore'] = this.ignore;
    data['sEvent'] = this.sEvent;
    data['_id'] = this.sId;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['assessmentWrapper'] = this.assessmentWrapper;
    if (this.assessmentCore != null) {
      data['assessmentCore'] = this.assessmentCore!.toJson();
    }
    if (this.wrapperAnalysis != null) {
      data['wrapperAnalysis'] = this.wrapperAnalysis!.toJson();
    }
/*    if (this.coreAnalysis != null) {
      data['coreAnalysis'] = this.coreAnalysis!.toJson();
    }*/
    data['user'] = this.user;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    if (this.originalResponse != null) {
      data['originalResponse'] = this.originalResponse!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Flow {
  dynamic id;
  dynamic section;
  dynamic question;
  dynamic time;
  dynamic action;
  dynamic state;
  String? response;
  dynamic endTime;

  Flow(
      {this.id,
        this.section,
        this.question,
        this.time,
        this.action,
        this.state,
        this.response,
        this.endTime});

  Flow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    section = json['section'];
    question = json['question'];
    time = json['time'];
    action = json['action'];
    state = json['state'];
    response = json['response'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section'] = this.section;
    data['question'] = this.question;
    data['time'] = this.time;
    data['action'] = this.action;
    data['state'] = this.state;
    data['response'] = this.response;
    data['endTime'] = this.endTime;
    return data;
  }
}

class AssessmentCore {
  Syllabus? syllabus;
  MarkingScheme? markingScheme;
  Config? config;
  List<Instructions>? instructions;
  List? customInstructions;
  bool? isArchived;
  dynamic version;
  String? sId;
  String? identifier;
  List? sectionInstructions;
  dynamic duration;
  List<Sections>? sections;
  List? sectionGroups;
  String? supergroup;
  List<Wrappers>? wrappers;
  List? customSyllabus;
  String? lastCategorized;
  String? createdAt;
  String? updatedAt;
  dynamic iV;
  String? analysis;

  AssessmentCore(
      {this.syllabus,
        this.markingScheme,
        this.config,
        this.instructions,
        this.customInstructions,
        this.isArchived,
        this.version,
        this.sId,
        this.identifier,
        this.sectionInstructions,
        this.duration,
        this.sections,
        this.sectionGroups,
        this.supergroup,
        this.wrappers,
        this.customSyllabus,
        this.lastCategorized,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.analysis});

  AssessmentCore.fromJson(Map<String, dynamic> json) {
    syllabus = json['syllabus'] != null
        ? new Syllabus.fromJson(json['syllabus'])
        : null;
    markingScheme = json['markingScheme'] != null
        ? new MarkingScheme.fromJson(json['markingScheme'])
        : null;
    config =
    json['config'] != null ? new Config.fromJson(json['config']) : null;
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions!.add(new Instructions.fromJson(v));
      });
    }
    if (json['customInstructions'] != null) {
      customInstructions = [];
      json['customInstructions'].forEach((v) {
        //customInstructions!.add(new Null.fromJson(v));
      });
    }
    isArchived = json['isArchived'];
    version = json['version'];
    sId = json['_id'];
    identifier = json['identifier'];
    if (json['sectionInstructions'] != null) {
      sectionInstructions = [];
      json['sectionInstructions'].forEach((v) {
        //sectionInstructions!.add(new Null.fromJson(v));
      });
    }
    duration = json['duration'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
    if (json['sectionGroups'] != null) {
      sectionGroups = [];
      json['sectionGroups'].forEach((v) {
        //sectionGroups!.add(new Null.fromJson(v));
      });
    }
    supergroup = json['supergroup'];
    if (json['wrappers'] != null) {
      wrappers = <Wrappers>[];
      json['wrappers'].forEach((v) {
        wrappers!.add(new Wrappers.fromJson(v));
      });
    }
    if (json['customSyllabus'] != null) {
      customSyllabus = [];
      json['customSyllabus'].forEach((v) {
        //customSyllabus!.add(new Null.fromJson(v));
      });
    }
    lastCategorized = json['lastCategorized'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    analysis = json['analysis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.syllabus != null) {
      data['syllabus'] = this.syllabus!.toJson();
    }
    if (this.markingScheme != null) {
      data['markingScheme'] = this.markingScheme!.toJson();
    }
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    if (this.instructions != null) {
      data['instructions'] = this.instructions!.map((v) => v.toJson()).toList();
    }
    if (this.customInstructions != null) {
      data['customInstructions'] =
          this.customInstructions!.map((v) => v.toJson()).toList();
    }
    data['isArchived'] = this.isArchived;
    data['version'] = this.version;
    data['_id'] = this.sId;
    data['identifier'] = this.identifier;
    if (this.sectionInstructions != null) {
      data['sectionInstructions'] =
          this.sectionInstructions!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    if (this.sections != null) {
      // data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    if (this.sectionGroups != null) {
      data['sectionGroups'] =
          this.sectionGroups!.map((v) => v.toJson()).toList();
    }
    data['supergroup'] = this.supergroup;
    if (this.wrappers != null) {
      data['wrappers'] = this.wrappers!.map((v) => v.toJson()).toList();
    }
    if (this.customSyllabus != null) {
      data['customSyllabus'] =
          this.customSyllabus!.map((v) => v.toJson()).toList();
    }
    data['lastCategorized'] = this.lastCategorized;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['analysis'] = this.analysis;
    return data;
  }
}

class Syllabus {
  List<Topics>? topics;

  Syllabus({this.topics});

  Syllabus.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(new Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  List<SubTopics>? subTopics;
  String? sId;
  String? id;

  Topics({this.subTopics, this.sId, this.id});

  Topics.fromJson(Map<String, dynamic> json) {
    if (json['subTopics'] != null) {
      subTopics = <SubTopics>[];
      json['subTopics'].forEach((v) {
        subTopics!.add(new SubTopics.fromJson(v));
      });
    }
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subTopics != null) {
      data['subTopics'] = this.subTopics!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class SubTopics {
  String? sId;
  String? id;

  SubTopics({this.sId, this.id});

  SubTopics.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class MarkingScheme {
  String? multipleCorrect;
  String? matchTheColumns;

  MarkingScheme({this.multipleCorrect, this.matchTheColumns});

  MarkingScheme.fromJson(Map<String, dynamic> json) {
    multipleCorrect = json['multipleCorrect'];
    matchTheColumns = json['matchTheColumns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['multipleCorrect'] = this.multipleCorrect;
    data['matchTheColumns'] = this.matchTheColumns;
    return data;
  }
}

class Config {
  List? extraSections;
  String? questionNumbering;

  Config({this.extraSections, this.questionNumbering});

  Config.fromJson(Map<String, dynamic> json) {
    if (json['extraSections'] != null) {
      extraSections = [];
      json['extraSections'].forEach((v) {
        //extraSections!.add(new Null.fromJson(v));
      });
    }
    questionNumbering = json['questionNumbering'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.extraSections != null) {
      data['extraSections'] =
          this.extraSections!.map((v) => v.toJson()).toList();
    }
    data['questionNumbering'] = this.questionNumbering;
    return data;
  }
}

class Instructions {
  String? type;
  String? instruction;
  List<SubInstructions>? subInstructions;

  Instructions({this.type, this.instruction, this.subInstructions});

  Instructions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    instruction = json['instruction'];
    if (json['sub_instructions'] != null) {
      subInstructions = <SubInstructions>[];
      json['sub_instructions'].forEach((v) {
        subInstructions!.add(new SubInstructions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['instruction'] = this.instruction;
    if (this.subInstructions != null) {
      data['sub_instructions'] =
          this.subInstructions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubInstructions {
  String? type;
  String? instruction;

  SubInstructions({this.type, this.instruction});

  SubInstructions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    instruction = json['instruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['instruction'] = this.instruction;
    return data;
  }
}

class Sections {
  dynamic duration;
  List<QuestionGroups>? questionGroups;
  List<Questions>? questions;
  String? sId;
  String? name;

  Sections(
      {this.duration,
        this.questionGroups,
        this.questions,
        this.sId,
        this.name});

  Sections.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    if (json['questionGroups'] != null) {
      questionGroups = <QuestionGroups>[];
      json['questionGroups'].forEach((v) {
        questionGroups!.add(new QuestionGroups.fromJson(v));
      });
    }
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    sId = json['_id'];
    name = json['name'];
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    if (this.questionGroups != null) {
      data['questionGroups'] =
          this.questionGroups!.map((v) => v.toJson()).toList();
    }
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }*/
}

class QuestionGroups {
  List<int>? questions;
  String? sId;
  dynamic selectNumberOfQuestions;
  String? selectionType;

  QuestionGroups(
      {this.questions,
        this.sId,
        this.selectNumberOfQuestions,
        this.selectionType});

  QuestionGroups.fromJson(Map<String, dynamic> json) {
    questions = json['questions'].cast<int>();
    sId = json['_id'];
    selectNumberOfQuestions = json['selectNumberOfQuestions'];
    selectionType = json['selectionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questions'] = this.questions;
    data['_id'] = this.sId;
    data['selectNumberOfQuestions'] = this.selectNumberOfQuestions;
    data['selectionType'] = this.selectionType;
    return data;
  }
}

class Questions {
  List? reports;
  dynamic correctMark;
  dynamic incorrectMark;
  String? sId;
  Question? question;
  String? topic;
  String? subTopic;

  Questions(
      {this.reports,
        this.correctMark,
        this.incorrectMark,
        this.sId,
        this.question,
        this.topic,
        this.subTopic});

  Questions.fromJson(Map<String, dynamic> json) {
    if (json['reports'] != null) {
      reports = [];
      json['reports'].forEach((v) {
        //reports!.add(new Null.fromJson(v));
      });
    }
    correctMark = json['correctMark'];
    incorrectMark = json['incorrectMark'];
    sId = json['_id'];
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
    topic = json['topic'];
    subTopic = json['sub_topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reports != null) {
      data['reports'] = this.reports!.map((v) => v.toJson()).toList();
    }
    data['correctMark'] = this.correctMark;
    data['incorrectMark'] = this.incorrectMark;
    data['_id'] = this.sId;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    data['topic'] = this.topic;
    data['sub_topic'] = this.subTopic;
    return data;
  }
}

class Question {
  List? answers;
  String? type;
  dynamic level;
  List? reports;
  String? sId;
  List<Options>? options;
  List? multiOptions;
  Statistics? statistics;

  Question(
      {this.answers,
        this.type,
        this.level,
        this.reports,
        this.sId,
        this.options,
        this.multiOptions,
        this.statistics});

  Question.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        //answers!.add(new Null.fromJson(v));
      });
    }
    type = json['type'];
    level = json['level'];
    if (json['reports'] != null) {
      reports = [];
      json['reports'].forEach((v) {
        //reports!.add(new Null.fromJson(v));
      });
    }
    sId = json['_id'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    if (json['multiOptions'] != null) {
      multiOptions = [];
      json['multiOptions'].forEach((v) {
        //multiOptions!.add(new Null.fromJson(v));
      });
    }
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['level'] = this.level;
    if (this.reports != null) {
      data['reports'] = this.reports!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.multiOptions != null) {
      data['multiOptions'] = this.multiOptions!.map((v) => v.toJson()).toList();
    }
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }
    return data;
  }
}

class Options {
  bool? isAlternateCorrect;
  dynamic votes;
  String? sId;
  bool? isCorrect;
  Content? content;

  Options(
      {this.isAlternateCorrect,
        this.votes,
        this.sId,
        this.isCorrect,
        this.content});

  Options.fromJson(Map<String, dynamic> json) {
    isAlternateCorrect = json['isAlternateCorrect'];
    votes = json['votes'];
    sId = json['_id'];
    isCorrect = json['isCorrect'];
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
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

class Content {
  dynamic rawContent;

  Content({this.rawContent});

  Content.fromJson(Map<String, dynamic> json) {
    rawContent = json['rawContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rawContent'] = this.rawContent;
    return data;
  }
}

class Statistics {
  QuestionProperties? questionProperties;
  PerfectTimeLimits? perfectTimeLimits;
  List<String>? attempts;
  dynamic medianTime;
  dynamic basedOnAttemptsCount;
  bool? fixed;
  dynamic demoRank;
  String? sId;
  String? processedAt;
  List<Rating>? rating;
  String? question;
  String? createdAt;
  String? updatedAt;
  dynamic iV;
  dynamic averageAccuracy;
  String? calculatedAt;

  Statistics(
      {this.questionProperties,
        this.perfectTimeLimits,
        this.attempts,
        this.medianTime,
        this.basedOnAttemptsCount,
        this.fixed,
        this.demoRank,
        this.sId,
        this.processedAt,
        this.rating,
        this.question,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.averageAccuracy,
        this.calculatedAt});

  Statistics.fromJson(Map<String, dynamic> json) {
    questionProperties = json['questionProperties'] != null
        ? new QuestionProperties.fromJson(json['questionProperties'])
        : null;
    perfectTimeLimits = json['perfectTimeLimits'] != null
        ? new PerfectTimeLimits.fromJson(json['perfectTimeLimits'])
        : null;
    attempts = json['attempts'].cast<String>();
    medianTime = json['medianTime'];
    basedOnAttemptsCount = json['basedOnAttemptsCount'];
    fixed = json['fixed'];
    demoRank = json['demoRank'];
    sId = json['_id'];
    processedAt = json['processedAt'];
    if (json['rating'] != null) {
      rating = <Rating>[];
      json['rating'].forEach((v) {
        rating!.add(new Rating.fromJson(v));
      });
    }
    question = json['question'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    averageAccuracy = json['averageAccuracy'];
    calculatedAt = json['calculatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionProperties != null) {
      data['questionProperties'] = this.questionProperties!.toJson();
    }
    if (this.perfectTimeLimits != null) {
      data['perfectTimeLimits'] = this.perfectTimeLimits!.toJson();
    }
    data['attempts'] = this.attempts;
    data['medianTime'] = this.medianTime;
    data['basedOnAttemptsCount'] = this.basedOnAttemptsCount;
    data['fixed'] = this.fixed;
    data['demoRank'] = this.demoRank;
    data['_id'] = this.sId;
    data['processedAt'] = this.processedAt;
    if (this.rating != null) {
      data['rating'] = this.rating!.map((v) => v.toJson()).toList();
    }
    data['question'] = this.question;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['averageAccuracy'] = this.averageAccuracy;
    data['calculatedAt'] = this.calculatedAt;
    return data;
  }
}

class QuestionProperties {
  dynamic level;

  QuestionProperties({this.level});

  QuestionProperties.fromJson(Map<String, dynamic> json) {
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
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

class Rating {
  String? sId;
  dynamic batch;
  dynamic initial;
  dynamic current;

  Rating({this.sId, this.batch, this.initial, this.current});

  Rating.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batch = json['batch'];
    initial = json['initial'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch'] = this.batch;
    data['initial'] = this.initial;
    data['current'] = this.current;
    return data;
  }
}

class Wrappers {
  String? sId;
  String? wrapper;

  Wrappers({this.sId, this.wrapper});

  Wrappers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    wrapper = json['wrapper'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['wrapper'] = this.wrapper;
    return data;
  }
}

class WrapperAnalysis {
  Difficulty? difficulty;
  List? marks;
  List<int>? hist;
  dynamic sumMarks;
  dynamic sumAccuracy;
  dynamic sumSqAccuracy;
  dynamic liveAttempts;
  dynamic totalAttempts;
  dynamic attemptsSynced;
  String? sId;
  String? core;
  List<wrapperAnalysisSections>? sections;
  List? submissions;
  String? processedAt;
  String? createdAt;
  String? updatedAt;
  dynamic iV;

  WrapperAnalysis(
      {this.difficulty,
        this.marks,
        this.hist,
        this.sumMarks,
        this.sumAccuracy,
        this.sumSqAccuracy,
        this.liveAttempts,
        this.totalAttempts,
        this.attemptsSynced,
        this.sId,
        this.core,
        this.sections,
        this.submissions,
        this.processedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  WrapperAnalysis.fromJson(Map<String, dynamic> json) {
    difficulty = json['difficulty'] != null
        ? new Difficulty.fromJson(json['difficulty'])
        : null;
    if (json['marks'] != null) {
      marks = [];
      json['marks'].forEach((v) {
        //marks!.add(new Null.fromJson(v));
      });
    }
    hist = json['hist'].cast<int>();
    sumMarks = json['sumMarks'];
    sumAccuracy = json['sumAccuracy'];
    sumSqAccuracy = json['sumSqAccuracy'];
    liveAttempts = json['liveAttempts'];
    totalAttempts = json['totalAttempts'];
    attemptsSynced = json['attemptsSynced'];
    sId = json['_id'];
    core = json['core'];
    if (json['sections'] != null) {
      sections = <wrapperAnalysisSections>[];
      json['sections'].forEach((v) {
        sections!.add(new wrapperAnalysisSections.fromJson(v));
      });
    }
    if (json['submissions'] != null) {
      submissions = [];
      json['submissions'].forEach((v) {
        //submissions!.add(new Null.fromJson(v));
      });
    }
    processedAt = json['processedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.difficulty != null) {
      data['difficulty'] = this.difficulty!.toJson();
    }
    if (this.marks != null) {
      data['marks'] = this.marks!.map((v) => v.toJson()).toList();
    }
    data['hist'] = this.hist;
    data['sumMarks'] = this.sumMarks;
    data['sumAccuracy'] = this.sumAccuracy;
    data['sumSqAccuracy'] = this.sumSqAccuracy;
    data['liveAttempts'] = this.liveAttempts;
    data['totalAttempts'] = this.totalAttempts;
    data['attemptsSynced'] = this.attemptsSynced;
    data['_id'] = this.sId;
    data['core'] = this.core;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    if (this.submissions != null) {
      data['submissions'] = this.submissions!.map((v) => v.toJson()).toList();
    }
    data['processedAt'] = this.processedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Difficulty {
  wrapperAnalysisEasy? easy;
  wrapperAnalysisEasy? medium;
  wrapperAnalysisEasy? hard;

  Difficulty({this.easy, this.medium, this.hard});

  Difficulty.fromJson(Map<String, dynamic> json) {
    easy = json['easy'] != null ? new wrapperAnalysisEasy.fromJson(json['easy']) : null;
    medium = json['medium'] != null ? new wrapperAnalysisEasy.fromJson(json['medium']) : null;
    hard = json['hard'] != null ? new wrapperAnalysisEasy.fromJson(json['hard']) : null;
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

class wrapperAnalysisEasy {
  dynamic correct;
  dynamic incorrect;
  dynamic time;
  dynamic totalAttempts;
  List? times;

  wrapperAnalysisEasy(
      {this.correct,
        this.incorrect,
        this.time,
        this.totalAttempts,
        this.times});

  wrapperAnalysisEasy.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    time = json['time'];
    totalAttempts = json['totalAttempts'];
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        //times!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['time'] = this.time;
    data['totalAttempts'] = this.totalAttempts;
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class wrapperAnalysisSections {
  dynamic incorrect;
  dynamic correct;
  dynamic sumMarks;
  List? marks;
  List? marksWithUser;
  dynamic sumTime;
  List<int>? hist;
  List? times;
  String? sId;
  String? id;

  wrapperAnalysisSections(
      {this.incorrect,
        this.correct,
        this.sumMarks,
        this.marks,
        this.marksWithUser,
        this.sumTime,
        this.hist,
        this.times,
        this.sId,
        this.id});

  wrapperAnalysisSections.fromJson(Map<String, dynamic> json) {
    incorrect = json['incorrect'];
    correct = json['correct'];
    sumMarks = json['sumMarks'];
    if (json['marks'] != null) {
      marks = [];
      json['marks'].forEach((v) {
        //marks!.add(new Null.fromJson(v));
      });
    }
    if (json['marksWithUser'] != null) {
      marksWithUser = [];
      json['marksWithUser'].forEach((v) {
        //marksWithUser!.add(new Null.fromJson(v));
      });
    }
    sumTime = json['sumTime'];
    hist = json['hist'].cast<int>();
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        //times!.add(new Null.fromJson(v));
      });
    }
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['incorrect'] = this.incorrect;
    data['correct'] = this.correct;
    data['sumMarks'] = this.sumMarks;
    if (this.marks != null) {
      data['marks'] = this.marks!.map((v) => v.toJson()).toList();
    }
    if (this.marksWithUser != null) {
      data['marksWithUser'] =
          this.marksWithUser!.map((v) => v.toJson()).toList();
    }
    data['sumTime'] = this.sumTime;
    data['hist'] = this.hist;
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}
/*

class CoreAnalysis {
  Difficulty? difficulty;
  List? marks;
  List<int>? hist;
  dynamic maxMarks;
  dynamic sumMarks;
  dynamic sumAccuracy;
  dynamic sumSqAccuracy;
  dynamic sumPickingAbility;
  dynamic sumSqPickingAbility;
  dynamic totalAttempts;
  String? sId;
  List<coreAnalysisSections>? sections;
  String? lastCategorized;
  List? submissions;
  String? createdAt;
  String? updatedAt;
  dynamic iV;

  CoreAnalysis(
      {this.difficulty,
        this.marks,
        this.hist,
        this.maxMarks,
        this.sumMarks,
        this.sumAccuracy,
        this.sumSqAccuracy,
        this.sumPickingAbility,
        this.sumSqPickingAbility,
        this.totalAttempts,
        this.sId,
        this.sections,
        this.lastCategorized,
        this.submissions,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CoreAnalysis.fromJson(Map<String, dynamic> json) {
    difficulty = json['difficulty'] != null
        ? new Difficulty.fromJson(json['difficulty'])
        : null;
    if (json['marks'] != null) {
      marks = [];
      json['marks'].forEach((v) {
        //marks!.add(new Null.fromJson(v));
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
    sId = json['_id'];
    if (json['sections'] != null) {
      sections = <coreAnalysisSections>[];
      json['sections'].forEach((v) {
        sections!.add(new coreAnalysisSections.fromJson(v));
      });
    }
    lastCategorized = json['lastCategorized'];
    if (json['submissions'] != null) {
      submissions = [];
      json['submissions'].forEach((v) {
        //submissions!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['_id'] = this.sId;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    data['lastCategorized'] = this.lastCategorized;
    if (this.submissions != null) {
      data['submissions'] = this.submissions!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
*/

class coreAnalysisSections {
  dynamic incorrect;
  dynamic correct;
  dynamic sumMarks;
  dynamic maxMarks;
  dynamic sumTime;
  List? marks;
  List<int>? hist;
  List? times;
  List<coreAnalysisQuestions>? questions;
  String? sId;
  String? id;

  coreAnalysisSections(
      {this.incorrect,
        this.correct,
        this.sumMarks,
        this.maxMarks,
        this.sumTime,
        this.marks,
        this.hist,
        this.times,
        this.questions,
        this.sId,
        this.id});

  coreAnalysisSections.fromJson(Map<String, dynamic> json) {
    incorrect = json['incorrect'];
    correct = json['correct'];
    sumMarks = json['sumMarks'];
    maxMarks = json['maxMarks'];
    sumTime = json['sumTime'];
    if (json['marks'] != null) {
      marks = [];
      json['marks'].forEach((v) {
        //marks!.add(new Null.fromJson(v));
      });
    }
    hist = json['hist'].cast<int>();
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        //times!.add(new Null.fromJson(v));
      });
    }
    if (json['questions'] != null) {
      questions = <coreAnalysisQuestions>[];
      json['questions'].forEach((v) {
        questions!.add(new coreAnalysisQuestions.fromJson(v));
      });
    }
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['incorrect'] = this.incorrect;
    data['correct'] = this.correct;
    data['sumMarks'] = this.sumMarks;
    data['maxMarks'] = this.maxMarks;
    data['sumTime'] = this.sumTime;
    if (this.marks != null) {
      data['marks'] = this.marks!.map((v) => v.toJson()).toList();
    }
    data['hist'] = this.hist;
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class coreAnalysisQuestions {
  dynamic sumSqTime;
  dynamic sumTime;
  dynamic correctAttempts;
  dynamic totalAttempts;
  List? times;
  String? sId;
  String? id;

  coreAnalysisQuestions(
      {this.sumSqTime,
        this.sumTime,
        this.correctAttempts,
        this.totalAttempts,
        this.times,
        this.sId,
        this.id});

  coreAnalysisQuestions.fromJson(Map<String, dynamic> json) {
    sumSqTime = json['sumSqTime'];
    sumTime = json['sumTime'];
    correctAttempts = json['correctAttempts'];
    totalAttempts = json['totalAttempts'];
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        //times!.add(new Null.fromJson(v));
      });
    }
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sumSqTime'] = this.sumSqTime;
    data['sumTime'] = this.sumTime;
    data['correctAttempts'] = this.correctAttempts;
    data['totalAttempts'] = this.totalAttempts;
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class Response {
  String? sId;
  List<ResponseSections>? sections;

  Response({this.sId, this.sections});

  Response.fromJson(Map<String, dynamic> json) {
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
  dynamic totalQuestions;
  List<ResSecQuestions>? questions;

  ResponseSections({this.name, this.totalQuestions, this.questions});

  ResponseSections.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalQuestions = json['total_questions'];
    if (json['questions'] != null) {
      questions = <ResSecQuestions>[];
      json['questions'].forEach((v) {
        questions!.add(new ResSecQuestions.fromJson(v));
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

class ResSecQuestions {
  String? sId;
  dynamic time;
  dynamic answer;
  dynamic state;

  ResSecQuestions({this.sId, this.time, this.answer, this.state});

  ResSecQuestions.fromJson(Map<String, dynamic> json) {
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

class Meta {
  List<metaSections>? sections;
  dynamic marks;
  dynamic questionsAttempted;
  dynamic correctQuestions;
  dynamic incorrectQuestions;
  dynamic correctTime;
  dynamic incorrectTime;
  dynamic unattemptedTime;
  dynamic precision;
  dynamic marksAttempted;
  dynamic marksGained;
  dynamic marksLost;
  Difficulty? difficulty;

  Meta(
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
        this.difficulty});

  Meta.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      sections = <metaSections>[];
      json['sections'].forEach((v) {
        sections!.add(new metaSections.fromJson(v));
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
        ? new Difficulty.fromJson(json['difficulty'])
        : null;
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
    return data;
  }
}

class metaSections with ChangeNotifier {
  String? name;
  List<metaQuestions>? questions;
  dynamic time;
  dynamic correctTime;
  dynamic incorrectTime;
  dynamic unattemptedTime;
  dynamic marks;
  dynamic marksAttempted;
  dynamic marksGained;
  dynamic marksLost;
  dynamic correct;
  dynamic incorrect;
  dynamic precision;

  metaSections(
      {this.name,
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

  metaSections.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['questions'] != null) {
      questions = <metaQuestions>[];
      json['questions'].forEach((v) {
        questions!.add(new metaQuestions.fromJson(v));
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

class metaQuestions {
  String? sId;
  dynamic mark;
  dynamic time;
  dynamic correct;

  metaQuestions({this.sId, this.mark, this.time, this.correct});

  metaQuestions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mark = json['mark'];
    time = json['time'];
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['mark'] = this.mark;
    data['time'] = this.time;
    data['correct'] = this.correct;
    return data;
  }
}

class Easy {
  dynamic correct;
  dynamic incorrect;
  dynamic time;
  dynamic totalAttempts;

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
  dynamic correct;
  dynamic incorrect;
  dynamic time;
  dynamic totalAttempts;

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

class CoreAnalysis_main {
  dynamic maxMarks;

  CoreAnalysis_main({this.maxMarks});

  CoreAnalysis_main.fromJson(Map<String, dynamic> json) {
    maxMarks = json['maxMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxMarks'] = this.maxMarks;
    return data;
  }
}
