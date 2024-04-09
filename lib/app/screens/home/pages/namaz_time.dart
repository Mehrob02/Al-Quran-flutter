
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:itube/app/screens/home.dart';
import 'package:itube/quran_provider/prayer__times.dart';
import 'package:itube/app/screens/home/screens/qibla_direction_screen.dart';

class NamazTime extends StatefulWidget {
  const NamazTime({super.key, });

  @override
  State<NamazTime> createState() => _NamazTimeState();
}

class _NamazTimeState extends State<NamazTime> {
  Map<String, dynamic>? prayerTimes;
@override
void  initState(){
  getCurrentHijriDate();
  DateTime date = DateTime.now();
  fetchPrayerTimes(locationCity!, locationCountry!).then((data) {
  setState(() {
    // Parse the timings from the response
    prayerTimes = data['data'][date.day-1]['timings'];
    debugPrint(data['data'][date.day-1].toString());
  });
}).catchError((error) {
  debugPrint('Error fetching prayer times: $error');
  debugPrint(prayerTimes.toString());
});

  super.initState();
} 
String getCurrentHijriDate() {
  HijriCalendar _hijriDate = HijriCalendar.now();
  Map<int, String> monthNames = {
    1: 'Muharram',
    2: 'Safar',
    3: 'Rabi\' al-Awwal',
    4: 'Rabi\' al-Thani',
    5: 'Jumada al-Awwal',
    6: 'Jumada al-Thani',
    7: 'Rajab',
    8: 'Sha\'ban',
    9: 'Ramadan',
    10: 'Shawwal',
    11: 'Dhu al-Qi\'dah',
    12: 'Dhu al-Hijjah',
  };
  String monthName = monthNames[_hijriDate.hMonth]!;

  return '${_hijriDate.hDay} $monthName ${_hijriDate.hYear}';
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: prayerTimes != null
          ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(getCurrentHijriDate()),
                                    ),
                                  ),
                          Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle, 
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Fajr'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(prayerTimes!['Fajr']),
                                    ),
                                  ),
                                  
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Sunrise'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(prayerTimes!['Sunrise']),
                                    ),
                                  ),
                                  
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Dhuhr'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(prayerTimes!['Dhuhr']),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Asr'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(prayerTimes!['Asr']),
                                    ),
                                  ),
                                  
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Mag\'rib'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(prayerTimes!['Maghrib']),
                                    ),
                                  ),
                                  
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('I\'sha'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(prayerTimes!['Isha']),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 70, 201, 77)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>QiblaDirectionScreen()));
                },
                child: Text("Detect the Qibla Direction", style: TextStyle(color: Colors.white)),
              ),
                  ],
                ),
              ),
            ),
          ):Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}