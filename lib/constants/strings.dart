import 'package:shared_preferences/shared_preferences.dart';

class Strings {
  static String BASEURL = '';

  static String logo_icon = BASEURL.replaceAll('/API/', '/')+'assets/img/logomob.png';
  static String logo_sm_icon = BASEURL.replaceAll('/API/', '/')+'assets/img/favicon.png';
  static String fetch_url = BASEURL+'fetchdata_API.php';
  static String insert_url = BASEURL+'insertdata_API.php';
  static String addImage_url = BASEURL+'addImage_API.php';
  static String otp_url = BASEURL+'get_otp.php';


/*
  getUserId() async {
    var customer_id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customer_id = prefs.getString('customer_id');
    return customer_id;
  }
*/

}