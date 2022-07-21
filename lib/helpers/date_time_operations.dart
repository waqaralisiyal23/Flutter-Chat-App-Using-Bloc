import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:intl/intl.dart';

@immutable
abstract class DateTimeOperations {
  static String getFormattedTime(Timestamp timestamp) =>
      DateFormat('hh:mm a').format(timestamp.toDate());
}
