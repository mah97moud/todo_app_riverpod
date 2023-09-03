import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_date_provider.g.dart';

@riverpod
class TaskDate extends _$TaskDate {
  @override
  DateTime? build() => null;

  void changeDate(DateTime date) {
    state = date;
  }

  String? date() {
    if (state == null) {
      return null;
    }
    return DateFormat('yyyy-MM-dd').format(state!);
  }

  void reset() => state = null;
}

@riverpod
class TaskStartDate extends _$TaskStartDate {
  @override
  DateTime? build() => null;

  void changeTime(DateTime date) {
    state = date;
  }

  String? time() {
    if (state == null) {
      return null;
    }
    return DateFormat('hh:mm a').format(state!);
  }

  void reset() => state = null;
}

@riverpod
class TaskEndDate extends _$TaskEndDate {
  @override
  DateTime? build() => null;

  void changeTime(DateTime date) {
    state = date;
  }

  String? time() {
    if (state == null) {
      return null;
    }
    return DateFormat('hh:mm a').format(state!);
  }

  void reset() => state = null;
}
