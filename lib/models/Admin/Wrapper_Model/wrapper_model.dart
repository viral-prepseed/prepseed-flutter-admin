class WrapperModel {
  bool? success;
  List<Wrappers>? wrappers;
  int? total;

  WrapperModel({this.success, this.wrappers, this.total});

  WrapperModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['wrappers'] != null) {
      wrappers = <Wrappers>[];
      json['wrappers'].forEach((v) {
        wrappers!.add(new Wrappers.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.wrappers != null) {
      data['wrappers'] = this.wrappers!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}


class Wrappers {
  String? slang;
  String? series;
  String? topic;
  String? section;
  String? label;
  bool? graded;
  bool? locked;
  bool? isCategorized;
  int? cost;
  int? reward;
  List<Null>? visibleForServices;
  String? description;
  String? comps;
  bool? isArchived;
  bool? hideResults;
  bool? showInReports;
  bool? onlyCBT;
  String? sId;
  Core? core;
  String? name;
  String? type;
  String? availableFrom;
  String? availableTill;
  String? visibleFrom;
  List<Phases>? phases;
  WrapperAnalysis? wrapperAnalysis;
  List<Tags>? tags;
  List<Null>? permissions;
  List<Null>? messages;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Wrappers(
      {
        this.slang,
        this.series,
        this.topic,
        this.section,
        this.label,
        this.graded,
        this.locked,
        this.isCategorized,
        this.cost,
        this.reward,
        this.visibleForServices,
        this.description,
        this.comps,
        this.isArchived,
        this.hideResults,
        this.showInReports,
        this.onlyCBT,
        this.sId,
        this.core,
        this.name,
        this.type,
        this.availableFrom,
        this.availableTill,
        this.visibleFrom,
        this.phases,
        this.wrapperAnalysis,
        this.tags,
        this.permissions,
        this.messages,
        this.createdAt,
        this.updatedAt,
        this.iV
      }
  );

  Wrappers.fromJson(Map<String, dynamic> json) {
    slang = json['slang'];
    series = json['series'];
    topic = json['topic'];
    section = json['section'];
    label = json['label'];
    graded = json['graded'];
    locked = json['locked'];
    isCategorized = json['isCategorized'];
    cost = json['cost'];
    reward = json['reward'];
    if (json['visibleForServices'] != null) {
      visibleForServices = <Null>[];
      json['visibleForServices'].forEach((v) {
        visibleForServices!.add(null);
      });
    }
    description = json['description'];
    comps = json['comps'];
    isArchived = json['isArchived'];
    hideResults = json['hideResults'];
    showInReports = json['showInReports'];
    onlyCBT = json['onlyCBT'];
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
    wrapperAnalysis = json['analysis'] != null
        ? new WrapperAnalysis.fromJson(json['analysis'])
        : null;
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    if (json['permissions'] != null) {
      permissions = <Null>[];
      json['permissions'].forEach((v) {
        permissions!.add(null);
      });
    }
    if (json['messages'] != null) {
      messages = <Null>[];
      json['messages'].forEach((v) {
        messages!.add(null);
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slang'] = this.slang;
    data['series'] = this.series;
    data['topic'] = this.topic;
    data['section'] = this.section;
    data['label'] = this.label;
    data['graded'] = this.graded;
    data['locked'] = this.locked;
    data['isCategorized'] = this.isCategorized;
    data['cost'] = this.cost;
    data['reward'] = this.reward;
    if (this.visibleForServices != null) {
      data['visibleForServices'] =
          null;
    }
    data['description'] = this.description;
    data['comps'] = this.comps;
    data['isArchived'] = this.isArchived;
    data['hideResults'] = this.hideResults;
    data['showInReports'] = this.showInReports;
    data['onlyCBT'] = this.onlyCBT;
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
    if (wrapperAnalysis != null) {
      data['analysis'] = this.wrapperAnalysis!.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) {
        v!.toString();
      }).toList();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) {
        v!.toString();
      }).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Core {
  String? sId;
  String? identifier;
  int? duration;
  String? createdAt;
  CoreAnalysis? coreAnalysis;

  Core(
      {this.sId,
        this.identifier,
        this.duration,
        this.createdAt,
        this.coreAnalysis});

  Core.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    identifier = json['identifier'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    coreAnalysis = json['analysis'] != null
        ? new CoreAnalysis.fromJson(json['analysis'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['identifier'] = this.identifier;
    data['duration'] = this.duration;
    data['createdAt'] = this.createdAt;
    if (this.coreAnalysis != null) {
      data['analysis'] = this.coreAnalysis!.toJson();
    }
    return data;
  }
}

class CoreAnalysis {
  int? maxMarks;
  String? sId;

  CoreAnalysis({this.maxMarks, this.sId});

  CoreAnalysis.fromJson(Map<String, dynamic> json) {
    maxMarks = json['maxMarks'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxMarks'] = this.maxMarks;
    data['_id'] = this.sId;
    return data;
  }
}

class Phases {
  String? name;
  String? slang;
  String? sId;
  Phase? phase;

  Phases({this.name, this.slang, this.sId, this.phase});

  Phases.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slang = json['slang'];
    sId = json['_id'];
    phase = json['phase'] != null ? new Phase.fromJson(json['phase']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slang'] = this.slang;
    data['_id'] = this.sId;
    if (this.phase != null) {
      data['phase'] = this.phase!.toJson();
    }
    return data;
  }
}

class Phase {
  String? sId;
  String? name;
  bool? isOpenForEnrollment;
  String? id;

  Phase({this.sId, this.name, this.isOpenForEnrollment, this.id});

  Phase.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isOpenForEnrollment = json['isOpenForEnrollment'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['isOpenForEnrollment'] = this.isOpenForEnrollment;
    data['id'] = this.id;
    return data;
  }
}

class WrapperAnalysis {
  int? liveAttempts;
  int? totalAttempts;
  String? sId;

  WrapperAnalysis({this.liveAttempts, this.totalAttempts, this.sId});

  WrapperAnalysis.fromJson(Map<String, dynamic> json) {
    liveAttempts = json['liveAttempts'];
    totalAttempts = json['totalAttempts'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['liveAttempts'] = this.liveAttempts;
    data['totalAttempts'] = this.totalAttempts;
    data['_id'] = this.sId;
    return data;
  }
}

class Tags {
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

