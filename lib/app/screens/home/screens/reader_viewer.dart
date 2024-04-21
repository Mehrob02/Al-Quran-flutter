import 'package:flutter/material.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/reader.dart';
import 'package:itube/app/screens/home/screens/reader_new.dart';
import 'package:itube/app/screens/home/screens/Settings.dart';

class ReaderViewer extends StatefulWidget {
  const ReaderViewer({super.key, required this.surah, required this.ayahs, required this.indexToScroll});
  final String surah;
  final int ayahs;
  final int indexToScroll;

  @override
  State<ReaderViewer> createState() => _ReaderViewerState();
}
bool isReaderView = true;
class _ReaderViewerState extends State<ReaderViewer> {
  @override
  Widget build(BuildContext context) {
    if(!isReaderView){
      return reader(widget.surah, widget.ayahs, widget.indexToScroll);
    }else{
      return ReaderNew(page:pages[surahs.indexOf(widget.surah)]-1);
    }
  }
}