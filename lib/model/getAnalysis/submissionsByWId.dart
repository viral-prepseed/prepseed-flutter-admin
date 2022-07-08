/* /assessment/getSubmissionDetails*/


import 'package:flutter/material.dart';

class SubmissionDetails with ChangeNotifier {
  bool? success;
  String? from;
  String? to;
  String? submittedOn;

  SubmissionDetails({this.success, this.from, this.to, this.submittedOn});

  SubmissionDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    from = json['from'];
    to = json['to'];
    submittedOn = json['submittedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['from'] = this.from;
    data['to'] = this.to;
    data['submittedOn'] = this.submittedOn;
    return data;
  }
}


class SubmissionMap {
  bool? graded;
  bool? live;
  String? sId;
  String? assessmentWrapper;
  String? createdAt;

  SubmissionMap(
      {this.graded,
        this.live,
        this.sId,
        this.assessmentWrapper,
        this.createdAt});

  SubmissionMap.fromJson(Map<String, dynamic> json) {
    graded = json['graded'];
    live = json['live'];
    sId = json['_id'];
    assessmentWrapper = json['assessmentWrapper'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['graded'] = this.graded;
    data['live'] = this.live;
    data['_id'] = this.sId;
    data['assessmentWrapper'] = this.assessmentWrapper;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

