class VideoPlaylistModel {
  Playlist? playlist;

  VideoPlaylistModel({this.playlist});

  VideoPlaylistModel.fromJson(Map<String, dynamic> json) {
    playlist = json['playlist'] != null ?  Playlist.fromJson(json['playlist']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (playlist != null) {
      data['playlist'] = playlist!.toJson();
    }
    return data;
  }
}

class Playlist {
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

  Playlist({this.title, this.thumbNailsUrls, this.sId, this.items, this.setting, this.tags, this.resourceType, this.hasAccessToContent, this.serviceMachineNamesRequired, this.serviceMachineNames});

  Playlist.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbNailsUrls = json['thumbNailsUrls'].cast<String>();
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
    if (json['serviceMachineNames'] != null) {
      serviceMachineNames = <Null>[].cast<String>();
     // json['serviceMachineNames'].forEach((v) { serviceMachineNames!.add(Null.fromJson(v)); });
    }
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
    if (serviceMachineNames != null) {
     // data['serviceMachineNames'] = this.serviceMachineNames!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? sId;
  String? availableFrom;
  String? availableTill;
  List<String>? tags;
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
      tags = <Null>[].cast<String>();
      //json['tags'].forEach((v) { tags!.add(new Null.fromJson(v)); });
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
      //data['tags'] = this.tags!.map((v) => v.toJson()).toList();
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
  Endpoints? endpoints;
  bool? isEmbeded;
  String? embedType;
  String? embedUrlId;
  String? type;
  List<Tags>? tags;
  String? createdBy;

  Resource({this.sId, this.title, this.description, this.thumbNailsUrls, this.endpoints, this.isEmbeded, this.embedType, this.embedUrlId, this.type, this.tags, this.createdBy});

  Resource.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    thumbNailsUrls = json['thumbNailsUrls'].cast<String>();
    endpoints = json['endpoints'] != null ? Endpoints.fromJson(json['endpoints']) : null;
    isEmbeded = json['isEmbeded'];
    embedType = json['embedType'];
    embedUrlId = json['embedUrlId'];
    type = json['type'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) { tags!.add(Tags.fromJson(v)); });
    }
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['thumbNailsUrls'] = thumbNailsUrls;
    if (endpoints != null) {
      data['endpoints'] = endpoints!.toJson();
    }
    data['isEmbeded'] = isEmbeded;
    data['embedType'] = embedType;
    data['embedUrlId'] = embedUrlId;
    data['type'] = type;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = createdBy;
    return data;
  }
}

class Endpoints {

  List<String>? endPoints;
  Endpoints({required this.endPoints});

  Endpoints.fromJson(Map<String, dynamic> json){
  endPoints = json['endpoints'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
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