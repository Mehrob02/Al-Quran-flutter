import 'package:flutter/material.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/quran_provider/quran_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../quran_provider/models/ayahtranslation.dart';
class AboutAyahViewer extends StatefulWidget {
  const AboutAyahViewer(this.surah, this.index, {Key? key}) : super(key: key);

  final int surah;
  final int index;

  @override
  State<AboutAyahViewer> createState() => _AboutAyahViewerState();
}


class _AboutAyahViewerState extends State<AboutAyahViewer> {
  @override
  void initState() {
    super.initState();
    _loadAyahTranslation();
    _getTranslationLanguage(); // Можете вызвать ваш метод загрузки здесь, после того как surah и index будут инициализированы
  }

  List<AyahTranslation>? ayahtranslation;
Future initTranslationLanguage() async{
    currentLanguage = await _getTranslationLanguage();
  }
  
  Future<String> _getTranslationLanguage() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("ayahTranslationLanguage")??'en';
  }
  void _loadAyahTranslation() async {
    ayahtranslation = await QuanRepository().getSurah(widget.surah+1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ayahtranslation == null
            ? const Center(child: CircularProgressIndicator())
            : Text(currentLanguage=='en'?"${ayahtranslation![widget.index].ayahTranslation}\n":"${surahsTranslationRu[widget.surah][widget.index]}");
  }
}

