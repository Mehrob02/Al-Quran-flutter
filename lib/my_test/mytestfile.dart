import 'package:flutter/material.dart';
import 'package:itube/Surahs/alBaqarah.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:quran/quran.dart';

class MyTest extends StatefulWidget {
  const MyTest({Key? key, required this.ayahNumber, required this.surahName, required this.value, required this.currentPage, required this.index}) : super(key: key);
 final int ayahNumber;
 final String surahName;
 final int value;
 final int currentPage;
 final int index;
  @override
  State<MyTest> createState() => _MyTestState();
}
int value = 1;
class _MyTestState extends State<MyTest> {
  @override
  void initState() {
    super.initState();
  }
  List <int> _getSurahNumbers(int page){
    return getPageData(page)
    .map((e) => int.parse(e['surah'].toString()))
    .toList();
  }
  @override
  void dispose() {
    debugPrint("ddds");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    List<int> list = List.generate(widget.ayahNumber, (index) => index+1);
    return Column(
          children: [
            Row(
              children: [
                Text(widget.surahName),
                DropdownButton<int>(
                  value: value,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? newValue) { // Исправлено здесь
                    setState(() {
                      value = newValue ?? 1;
                    });
                  },
                  items: list.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
       Text("${surahsTranslationRu[_getSurahNumbers(widget.currentPage).reversed.toList()[widget.index]-1][value-1]}")
          ],
        );
  }
}
