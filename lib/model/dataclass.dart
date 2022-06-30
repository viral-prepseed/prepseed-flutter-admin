import 'dart:convert';

import 'package:flutter/material.dart';
List<DataClass> dataClassFromJson(String str) =>
    List<DataClass>.from(json.decode(str).map((x) => DataClass.fromJson(x)));
String dataClassToJson(List<DataClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class DataClass with ChangeNotifier{
  DataClass({
     this.albumId,
     this.id,
     this.title,
     this.url,
     this.thumbnailUrl,
  });
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;
  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );
  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}