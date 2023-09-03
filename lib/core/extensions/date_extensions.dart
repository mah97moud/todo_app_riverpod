import 'package:intl/intl.dart';

extension DateExt on DateTime? {
  String get timeOnly => this == null ? '' : DateFormat('h:mm').format(this!);
  String get dateOnly =>
      this == null ? '' : DateFormat('yyyy-MM-dd').format(this!);
}
