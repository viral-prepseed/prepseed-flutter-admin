import 'package:flutter/material.dart';

class list_questions with ChangeNotifier {
  Wrapper? wrapper;
  Core? core;
  String? startTime;
  int? currTime;

  list_questions({this.wrapper, this.core, this.startTime, this.currTime});

  list_questions.fromJson(Map<String, dynamic> json) {
    wrapper =
    json['wrapper'] != null ? new Wrapper.fromJson(json['wrapper']) : null;
    core = json['core'] != null ? new Core.fromJson(json['core']) : null;
    startTime = json['startTime'];
    currTime = json['currTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wrapper != null) {
      data['wrapper'] = this.wrapper!.toJson();
    }
    if (this.core != null) {
      data['core'] = this.core!.toJson();
    }
    data['startTime'] = this.startTime;
    data['currTime'] = this.currTime;
    return data;
  }
}

class Wrapper with ChangeNotifier {
  bool? graded;
  int? cost;
  List? visibleForServices;
  String? sId;
  String? core;
  String? name;
  String? type;
  String? availableFrom;
  String? availableTill;
  List<Phases>? phases;
  String? analysis;
  List? permissions;

  Wrapper(
      {this.graded,
        this.cost,
        this.visibleForServices,
        this.sId,
        this.core,
        this.name,
        this.type,
        this.availableFrom,
        this.availableTill,
        this.phases,
        this.analysis,
        this.permissions});

  Wrapper.fromJson(Map<String, dynamic> json) {
    graded = json['graded'];
    cost = json['cost'];
    if (json['visibleForServices'] != null) {
      visibleForServices = <Null>[];
      /*json['visibleForServices'].forEach((v) {
        visibleForServices!.add(new Null.fromJson(v));
      });*/
    }
    sId = json['_id'];
    core = json['core'];
    name = json['name'];
    type = json['type'];
    availableFrom = json['availableFrom'];
    availableTill = json['availableTill'];
    if (json['phases'] != null) {
      phases = <Phases>[];
      json['phases'].forEach((v) {
        phases!.add(new Phases.fromJson(v));
      });
    }
    analysis = json['analysis'];
    if (json['permissions'] != null) {
      permissions = <Null>[];
      /*json['permissions'].forEach((v) {
        permissions!.add(new Null.fromJson(v));
      });*/
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['graded'] = this.graded;
    data['cost'] = this.cost;
    if (this.visibleForServices != null) {
      data['visibleForServices'] =
          this.visibleForServices!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['core'] = this.core;
    data['name'] = this.name;
    data['type'] = this.type;
    data['availableFrom'] = this.availableFrom;
    data['availableTill'] = this.availableTill;
    if (this.phases != null) {
      data['phases'] = this.phases!.map((v) => v.toJson()).toList();
    }
    data['analysis'] = this.analysis;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Phases {
  String? name;
  String? slang;
  String? sId;
  String? phase;

  Phases({this.name, this.slang, this.sId, this.phase});

  Phases.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slang = json['slang'];
    sId = json['_id'];
    phase = json['phase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slang'] = this.slang;
    data['_id'] = this.sId;
    data['phase'] = this.phase;
    return data;
  }
}

class Core with ChangeNotifier {
  Syllabus? syllabus;
  MarkingScheme? markingScheme;
  Config? config;
  List<Instructions>? instructions;
  // List<Null>? customInstructions;
  String? sId;
  List<Null>? sectionInstructions;
  int? duration;
  List<Sections>? sections;
  String? analysis;

  Core(
      {this.syllabus,
        this.markingScheme,
        this.config,
        this.instructions,
        // this.customInstructions,
        this.sId,
        this.sectionInstructions,
        this.duration,
        this.sections,
        this.analysis});

  Core.fromJson(Map<String, dynamic> json) {
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
/*    if (json['customInstructions'] != null) {
      customInstructions = <Null>[];
      json['customInstructions'].forEach((v) {
        customInstructions!.add(new Null.fromJson(v));
      });
    }*/
    sId = json['_id'];
/*    if (json['sectionInstructions'] != null) {
      sectionInstructions = <Null>[];
      json['sectionInstructions'].forEach((v) {
        sectionInstructions!.add(new Null.fromJson(v));
      });
    }*/
    duration = json['duration'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
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
/*    if (this.customInstructions != null) {
      data['customInstructions'] =
          this.customInstructions!.map((v) => v.toJson()).toList();
    }*/
    data['_id'] = this.sId;
/*    if (this.sectionInstructions != null) {
      data['sectionInstructions'] =
          this.sectionInstructions!.map((v) => v.toJson()).toList();
    }*/
    data['duration'] = this.duration;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    data['analysis'] = this.analysis;
    return data;
  }
}

class Syllabus {
  List<syllTopics>? topics;

  Syllabus({this.topics});

  Syllabus.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = <syllTopics>[];
      json['topics'].forEach((v) {
        topics!.add(new syllTopics.fromJson(v));
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

class syllTopics {
  List<SubTopics>? subTopics;
  String? sId;
  String? id;

  syllTopics({this.subTopics, this.sId, this.id});

  syllTopics.fromJson(Map<String, dynamic> json) {
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
  List<Null>? extraSections;
  String? questionNumbering;

  Config({this.extraSections, this.questionNumbering});

  Config.fromJson(Map<String, dynamic> json) {
    if (json['extraSections'] != null) {
      extraSections = <Null>[];
/*      json['extraSections'].forEach((v) {
        extraSections!.add(new Null.fromJson(v));
      });*/
    }
    questionNumbering = json['questionNumbering'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.extraSections != null) {
     /* data['extraSections'] =
          this.extraSections!.map((v) => v.toJson()).toList();*/
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

class Sections with ChangeNotifier {
  int? duration;
  List? questionGroups;
  List<Questions>? questions;
  String? name;

  Sections({this.duration, this.questionGroups, this.questions, this.name});

  Sections.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    if (json['questionGroups'] != null) {
      questionGroups = <Null>[];
/*      json['questionGroups'].forEach((v) {
        questionGroups!.add(new Null.fromJson(v));
      });*/
    }
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    if (this.questionGroups != null) {
 /*     data['questionGroups'] =
          this.questionGroups!.map((v) => v.toJson()).toList();*/
    }
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    return data;
  }
}

class Questions {
  int? correctMark;
  int? incorrectMark;
  Question? question;

  Questions({this.correctMark, this.incorrectMark, this.question});

  Questions.fromJson(Map<String, dynamic> json) {
    correctMark = json['correctMark'];
    incorrectMark = json['incorrectMark'];
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correctMark'] = this.correctMark;
    data['incorrectMark'] = this.incorrectMark;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    return data;
  }
}

class Question {
  String? type;
  String? dataType;
  String? sId;
  Content? content;
  List<Options>? options;
  List<MultiOptions>? multiOptions;
  Statistics? statistics;

  Question(
      {this.type,
        this.dataType,
        this.sId,
        this.content,
        this.options,
        this.multiOptions,
        this.statistics});

  Question.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    dataType = json['dataType'];
    sId = json['_id'];
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    if (json['multiOptions'] != null) {
      multiOptions = <MultiOptions>[];
      json['multiOptions'].forEach((v) {
        multiOptions!.add(new MultiOptions.fromJson(v));
      });
    }
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['dataType'] = this.dataType;
    data['_id'] = this.sId;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
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


class RawContent {
  List<Blocks>? blocks;

  RawContent({this.blocks});

  RawContent.fromJson(Map<String, dynamic> json) {
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

class Blocks {
  String? key;
  String? text;
  String? type;
  int? depth;
  List<InlineStyleRanges>? inlineStyleRanges;
  // List<Null>? entityRanges;

  Blocks(
      {this.key,
        this.text,
        this.type,
        this.depth,
        this.inlineStyleRanges,});

  Blocks.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    text = json['text'];
    type = json['type'];
    depth = json['depth'];
    if (json['inlineStyleRanges'] != null) {
      inlineStyleRanges = <InlineStyleRanges>[];
      json['inlineStyleRanges'].forEach((v) {
        inlineStyleRanges!.add(new InlineStyleRanges.fromJson(v));
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

    return data;
  }
}

class InlineStyleRanges {
  int? offset;
  int? length;
  String? style;

  InlineStyleRanges({this.offset, this.length, this.style});

  InlineStyleRanges.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    length = json['length'];
    style = json['style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['length'] = this.length;
    data['style'] = this.style;
    return data;
  }

}
class MultiOptions {
  String? id;

  MultiOptions({this.id});

  MultiOptions.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    return data;
  }
}

class Options {
  String? sId;
  Content? content;

  Options({this.sId,this.content});

  Options.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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

class Statistics {
  PerfectTimeLimits? perfectTimeLimits;
  String? sId;

  Statistics({this.perfectTimeLimits, this.sId});

  Statistics.fromJson(Map<String, dynamic> json) {
    perfectTimeLimits = json['perfectTimeLimits'] != null
        ? new PerfectTimeLimits.fromJson(json['perfectTimeLimits'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.perfectTimeLimits != null) {
      data['perfectTimeLimits'] = this.perfectTimeLimits!.toJson();
    }
    data['_id'] = this.sId;
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
