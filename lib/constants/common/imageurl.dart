import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

Future<String?> networkImageToBase64(String imageUrl) async {
  String bs4str = imageUrl;
  bs4str = bs4str.replaceAll('data:image/jpeg;base64,', '');
  Uint8List decodedbytes = base64.decode(bs4str);
  File decodedimgfile = await File("image.jpg").writeAsBytes(decodedbytes);
  print(decodedimgfile.path);
  String decodedpath = decodedimgfile.path;
  return decodedpath;
}