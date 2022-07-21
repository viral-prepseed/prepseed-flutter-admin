class UploadAssignmentModel {
  Data? data;
  String? filePath;

  UploadAssignmentModel({this.data, this.filePath});

  UploadAssignmentModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['filePath'] = filePath;
    return data;
  }
}

class Data {
  String? url;
  Fields? fields;

  Data({this.url, this.fields});

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    fields =
    json['fields'] != null ? Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    if (fields != null) {
      data['fields'] = fields!.toJson();
    }
    return data;
  }
}

class Fields {
  String? acl;
  String? key;
  String? mime;
  String? contentType;
  String? bucket;
  String? xAmzAlgorithm;
  String? xAmzCredential;
  String? xAmzDate;
  String? policy;
  String? xAmzSignature;

  Fields(
      {this.acl,
        this.key,
        this.mime,
        this.contentType,
        this.bucket,
        this.xAmzAlgorithm,
        this.xAmzCredential,
        this.xAmzDate,
        this.policy,
        this.xAmzSignature});

  Fields.fromJson(Map<String, dynamic> json) {
    acl = json['acl'];
    key = json['key'];
    mime = json['mime'];
    contentType = json['content-type'];
    bucket = json['bucket'];
    xAmzAlgorithm = json['X-Amz-Algorithm'];
    xAmzCredential = json['X-Amz-Credential'];
    xAmzDate = json['X-Amz-Date'];
    policy = json['Policy'];
    xAmzSignature = json['X-Amz-Signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acl'] = acl;
    data['key'] = key;
    data['mime'] = mime;
    data['content-type'] = contentType;
    data['bucket'] = bucket;
    data['X-Amz-Algorithm'] = xAmzAlgorithm;
    data['X-Amz-Credential'] = xAmzCredential;
    data['X-Amz-Date'] = xAmzDate;
    data['Policy'] = policy;
    data['X-Amz-Signature'] = xAmzSignature;
    return data;
  }
}