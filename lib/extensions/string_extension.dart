import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

extension Strings on String {
  DateTime stringToDate(String pattern) => DateFormat(pattern).parse(this);

  String yyyyMMdd(String pattern) {
    DateTime theDate = DateFormat(pattern).parse(this);
    return '${theDate.year}.${theDate.month.toString().dateTimeToString()}.${theDate.day.toString().dateTimeToString()}';
  }

  String dateTimeToString() {
    if (length == 1) return '0$this';
    return this;
  }

  String ddMMyyyy(String pattern) {
    DateTime theDate = DateFormat(pattern).parse(this);
    return '${theDate.day.toString().dateTimeToString()}.${theDate.month.toString().dateTimeToString()}.${theDate.year}';
  }

  String hhMM(String pattern) {
    DateTime theDate = DateFormat(pattern).parse(this);
    return '${theDate.hour.toString().dateTimeToString()}:${theDate.minute.toString().dateTimeToString()}';
  }

  int hh(String pattern) {
    DateTime dateTime = DateFormat(pattern).parse(this);
    return dateTime.hour;
  }

  String toGroupedFormat(int divider) {
    List<String> data = [];
    for (int i = 0; i < length; i += divider) {
      int offset = i + divider;
      data.add(substring(i, offset >= length ? length : offset));
    }
    return data.join(" ");
  }

  String toFormattedPhoneNumber() {
    return replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d+)'), (Match m) => "${m[1]} ${m[2]} ${m[3]}");
  }

  Future<String> toPhoneFormat() async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(this, 'RU');
    String? formattedNumber = await PhoneNumberUtil.formatAsYouType(number.phoneNumber!, number.isoCode!);
    return formattedNumber ?? this;
  }

  int toTimeStamp(String pattern) {
    DateTime theDate = DateFormat(pattern).parse(this);
    return theDate.millisecondsSinceEpoch;
  }
}
