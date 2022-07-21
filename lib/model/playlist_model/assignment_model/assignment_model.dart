class AssignmentModel {
  Playlist? playlist;

  AssignmentModel({this.playlist});

  AssignmentModel.fromJson(Map<String, dynamic> json) {
    playlist = json['playlist'] != null
        ? Playlist.fromJson(json['playlist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<AssignmentItems>? items;
 /* List<Null>? tags;*/
  String? resourceType;
  bool? hasAccessToContent;
  bool? serviceMachineNamesRequired;
 /* List<Null>? serviceMachineNames;*/

  Playlist(
      {this.title,
        this.thumbNailsUrls,
        this.sId,
        this.items,
       /* this.tags,*/
        this.resourceType,
        this.hasAccessToContent,
        this.serviceMachineNamesRequired,
       /* this.serviceMachineNames*/});

  Playlist.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbNailsUrls = json['thumbNailsUrls'].cast<String>();
    sId = json['_id'];
    if (json['items'] != null) {
      items = <AssignmentItems>[];
      json['items'].forEach((v) {
        items!.add(AssignmentItems.fromJson(v));
      });
    }
    /*if (json['tags'] != null) {
      tags = <Null>[];
      json['tags'].forEach((v) {
        tags!.add(new Null.fromJson(v));
      });
    }*/
    resourceType = json['resourceType'];
    hasAccessToContent = json['hasAccessToContent'];
    serviceMachineNamesRequired = json['serviceMachineNamesRequired'];
    /*if (json['serviceMachineNames'] != null) {
      serviceMachineNames = <Null>[];
      json['serviceMachineNames'].forEach((v) {
        serviceMachineNames!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['thumbNailsUrls'] = thumbNailsUrls;
    data['_id'] = sId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    /*if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }*/
    data['resourceType'] = resourceType;
    data['hasAccessToContent'] = hasAccessToContent;
    data['serviceMachineNamesRequired'] = serviceMachineNamesRequired;
   /* if (this.serviceMachineNames != null) {
      data['serviceMachineNames'] =
          this.serviceMachineNames!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class AssignmentItems {
  String? sId;
  String? availableFrom;
  void availableTill;
  List<void>? tags;
  String? resourceModel;
  bool? hasAccess;
  Resource? resource;
  List<String>? phases;

  AssignmentItems(
      {this.sId,
        this.availableFrom,
        this.availableTill,
        this.tags,
        this.resourceModel,
        this.hasAccess,
        this.resource,
        this.phases});

  AssignmentItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    availableFrom = json['availableFrom'];
    availableTill = json['availableTill'];
   /* if (json['tags'] != null) {
      tags = <Null>[];
      json['tags'].forEach((v) {
        tags!.add(new Null.fromJson(v));
      });
    }*/
    resourceModel = json['resourceModel'];
    hasAccess = json['hasAccess'];
    resource = json['resource'] != null
        ? Resource.fromJson(json['resource'])
        : null;
    phases = json['phases'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['availableFrom'] = availableFrom;
    /*data['availableTill'] = availableTill;*/
    /*if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }*/
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
  List<Files>? files;
  MarkingScheme? markingScheme;
  List<Tags>? tags;
  String? createdBy;

  Resource(
      {this.sId,
        this.title,
        this.description,
        this.thumbNailsUrls,
        this.files,
        this.markingScheme,
        this.tags,
        this.createdBy});

  Resource.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    thumbNailsUrls = json['thumbNailsUrls'].cast<String>();
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    markingScheme = json['markingScheme'] != null
        ? MarkingScheme.fromJson(json['markingScheme'])
        : null;
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['thumbNailsUrls'] = thumbNailsUrls;
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    if (markingScheme != null) {
      data['markingScheme'] = markingScheme!.toJson();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = createdBy;
    return data;
  }
}

class Files {
  String? sId;
  String? url;
  String? name;

  Files({this.sId, this.url, this.name});

  Files.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['url'] = url;
    data['name'] = name;
    return data;
  }
}

class MarkingScheme {
  List<Sections>? sections;

  MarkingScheme({this.sections});

  MarkingScheme.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String? sId;
  int? maxMarks;
  String? name;

  Sections({this.sId, this.maxMarks, this.name});

  Sections.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    maxMarks = json['maxMarks'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['maxMarks'] = maxMarks;
    data['name'] = name;
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