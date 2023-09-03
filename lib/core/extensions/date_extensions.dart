import 'package:intl/intl.dart';

extension DateExt on DateTime? {
  String get timeOnly => this == null ? '' : DateFormat('h:mm').format(this!);
}