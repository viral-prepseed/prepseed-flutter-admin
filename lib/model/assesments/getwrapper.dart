import 'dart:convert';

import 'package:flutter/cupertino.dart';


dynamic getwrappersFromJson(String str) =>
    List<getwrappers>.from(json.decode(str).map((x) => getwrappers.fromJson(x)));
String getwrappersToJson(List<getwrappers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<AssessmentWrappers> assessmentWrappersFromJson(String str) =>
    List<AssessmentWrappers>.from(json.decode(str).map((x) => AssessmentWrappers.fromJson(x)));
String assessmentWrappersToJson(List<AssessmentWrappers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class getwrappers with ChangeNotifier {
  bool? success;
  List<AssessmentWrappers>? assessmentWrappers;

  getwrappers({this.success, this.assessmentWrappers});

  getwrappers.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['assessmentWrappers'] != null) {
      assessmentWrappers = <AssessmentWrappers>[];
      json['assessmentWrappers'].forEach((v) {
        assessmentWrappers!.add(new AssessmentWrappers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.assessmentWrappers != null) {
      data['assessmentWrappers'] =
          this.assessmentWrappers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssessmentWrappers with ChangeNotifier {
  String? slang;
  String? series;
  String? topic;
  String? section;
  String? label;
  bool? graded;
  int? cost;
  int? reward;
  List<String>? visibleForServices;
  String? description;
  String? comps;
  String? sId;
  Core? core;
  String? name;
  String? type;
  String? availableFrom;
  String? availableTill;
  String? visibleFrom;
  List<Phases>? phases;
  List<Tags>? tags;

  AssessmentWrappers(
      {this.slang,
        this.series,
        this.topic,
        this.section,
        this.label,
        this.graded,
        this.cost,
        this.reward,
        this.visibleForServices,
        this.description,
        this.comps,
        this.sId,
        this.core,
        this.name,
        this.type,
        this.availableFrom,
        this.availableTill,
        this.visibleFrom,
        this.phases,
        this.tags});

  AssessmentWrappers.fromJson(Map<String, dynamic> json) {
    slang = json['slang'];
    series = json['series'];
    topic = json['topic'];
    section = json['section'];
    label = json['label'];
    graded = json['graded'];
    cost = json['cost'];
    reward = json['reward'];
    visibleForServices = json['visibleForServices'].cast<String>();
    description = json['description'];
    comps = json['comps'];
    sId = json['_id'];
    core = json['core'] != null ? new Core.fromJson(json['core']) : null;
    name = json['name'];
    type = json['type'];
    availableFrom = json['availableFrom'];
    availableTill = json['availableTill'];
    visibleFrom = json['visibleFrom'];
    if (json['phases'] != null) {
      phases = <Phases>[];
      json['phases'].forEach((v) {
        phases!.add(new Phases.fromJson(v));
      });
    }
/*    if (json['messages'] != null) {
      messages = <Null>[];
      json['messages'].forEach((v) {
        messages!.add(new Null.fromJson(v));
      });
    }*/
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slang'] = this.slang;
    data['series'] = this.series;
    data['topic'] = this.topic;
    data['section'] = this.section;
    data['label'] = this.label;
    data['graded'] = this.graded;
    data['cost'] = this.cost;
    data['reward'] = this.reward;
    data['visibleForServices'] = this.visibleForServices;
    data['description'] = this.description;
    data['comps'] = this.comps;
    data['_id'] = this.sId;
    if (this.core != null) {
      data['core'] = this.core!.toJson();
    }
    data['name'] = this.name;
    data['type'] = this.type;
    data['availableFrom'] = this.availableFrom;
    data['availableTill'] = this.availableTill;
    data['visibleFrom'] = this.visibleFrom;
    if (this.phases != null) {
      data['phases'] = this.phases!.map((v) => v.toJson()).toList();
    }
/*    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }*/
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Core with ChangeNotifier {
  Syllabus? syllabus;
  List<Instructions>? instructions;
  List<Null>? customInstructions;
  String? sId;
  List<Null>? sectionInstructions;
  int? duration;
  List<Null>? customSyllabus;

  Core(
      {this.syllabus,
        this.instructions,
        this.customInstructions,
        this.sId,
        this.sectionInstructions,
        this.duration,
        this.customSyllabus});

  Core.fromJson(Map<String, dynamic> json) {
    syllabus = json['syllabus'] != null
        ? new Syllabus.fromJson(json['syllabus'])
        : null;
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions!.add(new Instructions.fromJson(v));
      });
    }
    if (json['customInstructions'] != null) {
      customInstructions = <Null>[];
      json['customInstructions'].forEach((v) {
        // customInstructions!.add(new Null.fromJson(v));
      });
    }
    sId = json['_id'];
    if (json['sectionInstructions'] != null) {
      sectionInstructions = <Null>[];
      json['sectionInstructions'].forEach((v) {
        // sectionInstructions!.add(new Null.fromJson(v));
      });
    }
    duration = json['duration'];
    if (json['customSyllabus'] != null) {
      customSyllabus = <Null>[];
      json['customSyllabus'].forEach((v) {
        // customSyllabus!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.syllabus != null) {
      data['syllabus'] = this.syllabus!.toJson();
    }
    if (this.instructions != null) {
      data['instructions'] = this.instructions!.map((v) => v.toJson()).toList();
    }
    if (this.customInstructions != null) {
      /*data['customInstructions'] =
          this.customInstructions!.map((v) => v.toJson()).toList();*/
    }
    data['_id'] = this.sId;
    if (this.sectionInstructions != null) {
      /*data['sectionInstructions'] =
          this.sectionInstructions!.map((v) => v.toJson()).toList();*/
    }
    data['duration'] = this.duration;
    if (this.customSyllabus != null) {
      /*data['customSyllabus'] =
          this.customSyllabus!.map((v) => v.toJson()).toList();*/
    }
    return data;
  }
}

class Syllabus with ChangeNotifier {
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

class Topics with ChangeNotifier {
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

class SubTopics with ChangeNotifier{
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

class Instructions with ChangeNotifier{
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

class SubInstructions with ChangeNotifier {
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

class Phases with ChangeNotifier {
  String? name;
  String? slang;
  String? sId;
  String? phase;
  String? availableFrom;

  Phases({this.name, this.slang, this.sId, this.phase, this.availableFrom});

  Phases.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slang = json['slang'];
    sId = json['_id'];
    phase = json['phase'];
    availableFrom = json['availableFrom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slang'] = this.slang;
    data['_id'] = this.sId;
    data['phase'] = this.phase;
    data['availableFrom'] = this.availableFrom;
    return data;
  }
}

class Tags with ChangeNotifier{
  String? sId;
  String? key;
  String? value;

  Tags({this.sId, this.key, this.value});

  Tags.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
