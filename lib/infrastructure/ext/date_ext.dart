import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String hourStringForm({String pattern = "HH:MM", String locale = 'id'}) => DateFormat(pattern).format(this);

  String dateStringForm({String pattern = 'dd/MM/yyyy', String locale = 'id_ID'}) {
    final dateFormater = DateFormat(pattern, locale);
    return dateFormater.format(this);
  }

  String toMonthYearString() {
    final formatter = DateFormat('MMMM yyyy', 'id_ID');
    return formatter.format(this);
  }
}
