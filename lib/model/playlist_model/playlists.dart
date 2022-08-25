class playlist_model {
  List? subjects;
  PlaylistQuery? playlistQuery;
  PlaylistTypeLabels? playlistTypeLabels;
  List<Playlists>? playlists;

  playlist_model({this.subjects, this.playlistQuery, this.playlistTypeLabels, this.playlists});

  playlist_model.fromJson(Map<String, dynamic> json) {
    //if (json['subjects'] != null) {
      subjects = <Null>[];
      // json['subjects'].forEach((v) { subjects!.add(new Null.fromJson(v)); });
    //}
    playlistQuery = json['playlistQuery'] != null ? PlaylistQuery.fromJson(json['playlistQuery']) : null;
    playlistTypeLabels = json['playlistTypeLabels'] != null ? PlaylistTypeLabels.fromJson(json['playlistTypeLabels']) : null;
    if (json['playlists'] != null) {
      playlists = <Playlists>[];
      json['playlists'].forEach((v) { playlists!.add(Playlists.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (playlistQuery != null) {
      data['playlistQuery'] = playlistQuery!.toJson();
    }
    if (playlistTypeLabels != null) {
      data['playlistTypeLabels'] = playlistTypeLabels!.toJson();
    }
    if (playlists != null) {
      data['playlists'] = playlists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlaylistQuery {
  List<And>? and;

  PlaylistQuery({this.and});

  PlaylistQuery.fromJson(Map<String, dynamic> json) {
    if (json['$and'] != null) {
      and = <And>[];
      json['$and'].forEach((v) { and!.add(And.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (and != null) {
      data['$and'] = and!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class And {
  List<Or>? or;

  And({this.or});

  And.fromJson(Map<String, dynamic> json) {
    if (json['$or'] != null) {
      or = <Or>[];
      json['$or'].forEach((v) { or!.add(Or.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (or != null) {
      data['$or'] = or!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Or {
  AccessibleToValue? accessibleToValue;
  String? accessibleToType;

  Or({this.accessibleToValue, this.accessibleToType});

  Or.fromJson(Map<String, dynamic> json) {
    accessibleToValue = json['accessibleTo.value'] != null ? AccessibleToValue.fromJson(json['accessibleTo.value']) : null;
    accessibleToType = json['accessibleTo.type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accessibleToValue != null) {
      data['accessibleTo.value'] = accessibleToValue!.toJson();
    }
    data['accessibleTo.type'] = accessibleToType;
    return data;
  }
}

class AccessibleToValue {
  List<String>? inId;

  AccessibleToValue({this.inId});

  AccessibleToValue.fromJson(Map<String, dynamic> json) {
    inId = json['in'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['in'] = inId;
    return data;
  }
}

class PlaylistTypeLabels {
  String? video;
  String? resourceDocument;
  String? assignment;

  PlaylistTypeLabels({this.video, this.resourceDocument, this.assignment});

  PlaylistTypeLabels.fromJson(Map<String, dynamic> json) {
    video = json['Video'];
    resourceDocument = json['ResourceDocument'];
    assignment = json['Assignment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Video'] = video;
    data['ResourceDocument'] = resourceDocument;
    data['Assignment'] = assignment;
    return data;
  }
}

class Playlists {
  String? title;
  List<String>? thumbNailsUrls;
  String? sId;
  List<Items>? items;
  Setting? setting;
  List<Tags>? tags;
  String? resourceType;
  bool? hasAccessToContent;
  bool? serviceMachineNamesRequired;
  List<String>? serviceMachineNames;
  String? subject;

  Playlists({this.title, this.thumbNailsUrls, this.sId, this.items, this.setting, this.tags, this.resourceType, this.hasAccessToContent, this.serviceMachineNamesRequired, this.serviceMachineNames, this.subject});

  Playlists.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbNailsUrls = json['thumbNailsUrls'];
    sId = json['_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) { items!.add(Items.fromJson(v)); });
    }
    setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) { tags!.add(Tags.fromJson(v)); });
    }
    resourceType = json['resourceType'];
    hasAccessToContent = json['hasAccessToContent'];
    serviceMachineNamesRequired = json['serviceMachineNamesRequired'];
    serviceMachineNames = json['serviceMachineNames'].cast<String>();
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['thumbNailsUrls'] = thumbNailsUrls;
    data['_id'] = sId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (setting != null) {
      data['setting'] = setting!.toJson();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['resourceType'] = resourceType;
    data['hasAccessToContent'] = hasAccessToContent;
    data['serviceMachineNamesRequired'] = serviceMachineNamesRequired;
    data['serviceMachineNames'] = serviceMachineNames;
    data['subject'] = subject;
    return data;
  }
}

class Items {
  String? sId;
  String? availableFrom;
  dynamic availableTill;
  List? tags;
  String? resourceModel;
  bool? hasAccess;
  Resource? resource;
  List<String>? phases;

  Items({this.sId, this.availableFrom, this.availableTill, this.tags, this.resourceModel, this.hasAccess, this.resource, this.phases});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    availableFrom = json['availableFrom'];
    availableTill = json['availableTill'];
    if (json['tags'] != null) {
      tags = <Null>[];
      // json['tags'].forEach((v) { tags!.add(new Null.fromJson(v)); });
    }
    resourceModel = json['resourceModel'];
    hasAccess = json['hasAccess'];
    resource = json['resource'] != null ? Resource.fromJson(json['resource']) : null;
    phases = json['phases'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['availableFrom'] = availableFrom;
    data['availableTill'] = availableTill;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['resourceModel'] = resourceModel;
    data['hasAccess'] = hasAccess;
    if (resource != null) {
      data['resource'] = resource!.toJson();
    }
    data['phases'] = phases;
    return data;
  }
}

class Resource {
  String? sId;
  String? title;
  String? description;
  List<String>? thumbNailsUrls;
  bool? isEmbeded;
  String? embedType;
  String? type;
  List<Tags>? tags;

  Resource({this.sId, this.title, this.description, this.thumbNailsUrls, this.isEmbeded, this.embedType, this.type, this.tags});

  Resource.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    thumbNailsUrls = json['thumbNailsUrls'].cast<String>();
    isEmbeded = json['isEmbeded'];
    embedType = json['embedType'];
    type = json['type'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) { tags!.add(Tags.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['thumbNailsUrls'] = thumbNailsUrls;
    data['isEmbeded'] = isEmbeded;
    data['embedType'] = embedType;
    data['type'] = type;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class Setting {
  String? groupBy;
  String? theme;
  String? thumbnailViewTheme;
  String? sId;
  String? thumbnailBackgroundColor;

  Setting({this.groupBy, this.theme, this.thumbnailViewTheme, this.sId, this.thumbnailBackgroundColor});

  Setting.fromJson(Map<String, dynamic> json) {
    groupBy = json['groupBy'];
    theme = json['theme'];
    thumbnailViewTheme = json['thumbnailViewTheme'];
    sId = json['_id'];
    thumbnailBackgroundColor = json['thumbnailBackgroundColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupBy'] = groupBy;
    data['theme'] = theme;
    data['thumbnailViewTheme'] = thumbnailViewTheme;
    data['_id'] = sId;
    data['thumbnailBackgroundColor'] = thumbnailBackgroundColor;
    return data;
  }
}
