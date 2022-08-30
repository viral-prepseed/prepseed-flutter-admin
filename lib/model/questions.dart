class QuestionClass{
  final String type;
  final String text;
  final String id;
  final dynamic correctMarks;
  final dynamic incorrectMarks;
  dynamic queImage;
  dynamic optImage;
  dynamic linkedText;
  dynamic linkedImg;
  final List<Option> options;
  bool isMarked;
  Option? selectedOption;

  QuestionClass({
    required this.type,
    required this.text,
    required this.id,
    required this.correctMarks,
    required this.incorrectMarks,
    this.queImage,
    this.optImage,
    this.linkedText,
    this.linkedImg,
    required this.options,
    this.isMarked = false,
    this.selectedOption
  });
}

class Option {
  final String text;
  final dynamic id;

  Option({required this.text, required this.id});
}




class QuestionContents {
  List<Blocks>? blocks;
  dynamic entityMap;

  QuestionContents({this.blocks, this.entityMap});

  QuestionContents.fromJson(Map<String, dynamic> json) {
    if (json['blocks'] != null) {
      blocks = <Blocks>[];
      json['blocks'].forEach((v) { blocks!.add(new Blocks.fromJson(v)); });
    }
    // entityMap = json['entityMap'] != null ? new Data.fromJson(json['entityMap']) : null;
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
  List<InlineStyleRanges>? inlineStyleRanges;
  List<EntityRanges>? entityRanges;
  dynamic data;

  Blocks({this.key, this.text, this.type, this.depth, this.inlineStyleRanges, this.entityRanges, this.data});

  Blocks.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    text = json['text'];
    type = json['type'];
    depth = json['depth'];
    if (json['inlineStyleRanges'] != null) {
      inlineStyleRanges = <InlineStyleRanges>[];
      json['inlineStyleRanges'].forEach((v) { inlineStyleRanges!.add(new InlineStyleRanges.fromJson(v)); });
    }
    if (json['entityRanges'] != null) {
      entityRanges = <EntityRanges>[];
      json['entityRanges'].forEach((v) { entityRanges!.add(new EntityRanges.fromJson(v)); });
    }
    // data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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


Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}


class QuestionContent {
  List<Blocks>? blocks;
  dynamic entityMap;

  QuestionContent({this.blocks, this.entityMap});

  QuestionContent.fromJson(Map<String, dynamic> json) {
    if (json['blocks'] != null) {
      blocks = <Blocks>[];
      json['blocks'].forEach((v) { blocks!.add(new Blocks.fromJson(v)); });
    }
    // entityMap = json['entityMap'] != null ? new Data.fromJson(json['entityMap']) : null;
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

