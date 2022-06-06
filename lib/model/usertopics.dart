class UserTopics {
  List<Topics>? topics;

  UserTopics({this.topics});

  UserTopics.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? name;
  Difficulty? difficulty;
  List<SubTopics>? subTopics;
  dynamic percentComplete;

  Topics(
      {this.sId,
        this.name,
        this.difficulty,
        this.subTopics,
        required this.percentComplete});

  Topics.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    difficulty = json['difficulty'] != null
        ? new Difficulty.fromJson(json['difficulty'])
        : null;
    if (json['sub_topics'] != null) {
      subTopics = <SubTopics>[];
      json['sub_topics'].forEach((v) {
        subTopics!.add(new SubTopics.fromJson(v));
      });
    }
    percentComplete = json['percent_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.difficulty != null) {
      data['difficulty'] = this.difficulty!.toJson();
    }
    if (this.subTopics != null) {
      data['sub_topics'] = this.subTopics!.map((v) => v.toJson()).toList();
    }
    data['percent_complete'] = this.percentComplete;
    return data;
  }
}

class Difficulty {
  int? easy;
  int? medium;
  int? hard;

  Difficulty({this.easy, this.medium, this.hard});

  Difficulty.fromJson(Map<String, dynamic> json) {
    easy = json['Easy'];
    medium = json['Medium'];
    hard = json['Hard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Easy'] = this.easy;
    data['Medium'] = this.medium;
    data['Hard'] = this.hard;
    return data;
  }
}

class SubTopics {
  String? sId;
  int? id;
  String? name;
  String? tag;
  List<Concepts>? concepts;
  dynamic percentComplete;
  bool? hide;

  SubTopics(
      {this.sId,
        this.id,
        this.name,
        this.tag,
        this.concepts,
        this.percentComplete,
        this.hide});

  SubTopics.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
    if (json['concepts'] != null) {
      concepts = <Concepts>[];
      json['concepts'].forEach((v) {
        concepts!.add(new Concepts.fromJson(v));
      });
    }
    percentComplete = json['percent_complete'];
    hide = json['hide'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['tag'] = this.tag;
    if (this.concepts != null) {
      data['concepts'] = this.concepts!.map((v) => v.toJson()).toList();
    }
    data['percent_complete'] = this.percentComplete;
    data['hide'] = this.hide;
    return data;
  }
}

class Concepts {
  String? sId;
  Concept? concept;

  Concepts({this.sId, this.concept});

  Concepts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    concept =
    json['concept'] != null ? new Concept.fromJson(json['concept']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.concept != null) {
      data['concept'] = this.concept!.toJson();
    }
    return data;
  }
}

class Concept {
  String? sId;
  String? name;
  String? topic;
  String? subTopic;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Concept(
      {this.sId,
        this.name,
        this.topic,
        this.subTopic,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Concept.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    topic = json['topic'];
    subTopic = json['sub_topic'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['topic'] = this.topic;
    data['sub_topic'] = this.subTopic;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
