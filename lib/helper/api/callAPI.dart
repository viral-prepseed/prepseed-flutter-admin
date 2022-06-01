import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prepseed/constants/strings.dart';
import 'package:prepseed/model/clientNames.dart';

class callAPI{

  Future<listClientNames> fetchClientNames() async{
    final response = await http.get(Uri.parse(Strings.listNames));
    if (response.statusCode == 200) {
      return listClientNames.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Client Names');
    }
  }

}