import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;

void setupTimezones() {
  tz.initializeTimeZones();
}
