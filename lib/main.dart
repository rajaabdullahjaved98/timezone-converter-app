import 'package:flutter/material.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:intl/intl.dart';
import 'setup.dart'; // import the setup function

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupTimezones();
  runApp(TimezoneConverterApp());
}

class TimezoneConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timezone Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TimezoneConverterPage(),
    );
  }
}

class TimezoneConverterPage extends StatefulWidget {
  @override
  _TimezoneConverterPageState createState() => _TimezoneConverterPageState();
}

class _TimezoneConverterPageState extends State<TimezoneConverterPage> {
  String? selectedTimeZone1;
  String? selectedTimeZone2;
  DateTime? convertedTime;

  List<String> timezones = tz.timeZoneDatabase.locations.keys.toList();

  void convertTime() {
    if (selectedTimeZone1 != null && selectedTimeZone2 != null) {
      var now = DateTime.now();
      var location1 = tz.getLocation(selectedTimeZone1!);
      var location2 = tz.getLocation(selectedTimeZone2!);

      var timeInZone1 = tz.TZDateTime.now(location1);
      var timeInZone2 = tz.TZDateTime.from(timeInZone1, location2);

      setState(() {
        convertedTime = timeInZone2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timezone Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Select Time Zone 1'),
              value: selectedTimeZone1,
              items: timezones.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedTimeZone1 = newValue;
                });
              },
            ),
            DropdownButton<String>(
              hint: Text('Select Time Zone 2'),
              value: selectedTimeZone2,
              items: timezones.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedTimeZone2 = newValue;
                });
              },
            ),
            ElevatedButton(
              onPressed: convertTime,
              child: Text('Convert Time'),
            ),
            if (convertedTime != null)
              Text(
                'Converted Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(convertedTime!)}',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
