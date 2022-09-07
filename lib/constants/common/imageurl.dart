import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

 Future<Uint8List> networkImageToBase64(String imageUrl) async {
  String bs4str = imageUrl;
  bs4str = bs4str.replaceAll(RegExp(r'data:image/(.+?);base64,'), '');
  Uint8List decodedbytes =  Base64Decoder().convert(bs4str);
/*
  File decodedimgfile = await File("s.png").writeAsBytes(decodedbytes);
  print(decodedimgfile.path);
  String decodedpath = decodedimgfile.path;
*/
  print(decodedbytes);
  return decodedbytes;
}