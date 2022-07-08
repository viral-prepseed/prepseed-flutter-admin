import 'package:intl/intl.dart';

class FormatDateTime{
  dateTimeFormatter(dateTime){
    var dateFormatted = DateFormat("dd-MM-yyyy").format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTime));
    return dateFormatted;
  }

  dateMonthFormatter(dateTime){
    var dateFormatted = DateFormat("dd MMMM").format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTime));
    return dateFormatted;
  }
}