import 'package:shared_preferences/shared_preferences.dart';

class Strings {
  static String STATIC_URL = "https://static.prepseed.com";
  static String BASEURL = 'https://napi.prepseed.com';

  static String CLIENT_BASE = BASEURL + "/clients";
  static String USER_BASE = BASEURL + "/users";
  static String ASSESSMENT_BASE = BASEURL + "/assessment";
  //getwrappers/


  static String listNames = CLIENT_BASE + '/listNames';
  static String signIn = USER_BASE + '/signin';
  static String getWrappers = ASSESSMENT_BASE + '/getwrappers';

/*
  static String logo_icon = BASEURL.replaceAll('/API/', '/')+'assets/img/logomob.png';
  static String logo_sm_icon = BASEURL.replaceAll('/API/', '/')+'assets/img/favicon.png';
  static String fetch_url = BASEURL+'fetchdata_API.php';
  static String insert_url = BASEURL+'insertdata_API.php';
  static String addImage_url = BASEURL+'addImage_API.php';
  static String otp_url = BASEURL+'get_otp.php';
*/


/*
  getUserId() async {
    var customer_id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customer_id = prefs.getString('customer_id');
    return customer_id;
  }
*/

}