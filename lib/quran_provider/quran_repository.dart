import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/quran_provider/models/ayah_sound.dart';
import 'package:itube/quran_provider/models/ayahtranslation.dart';
import 'package:itube/quran_provider/models/surahs.dart';

class QuanRepository {
  final Dio _dio = Dio();

  Future<List<Surahs>> getSurahList() async {
    try {
      final response =
          await _dio.get('https://quranapi.pages.dev/api/surah.json');
      final List<dynamic> data = response.data;
      final surahList = data.map((e) => Surahs(
                 e['surahName'],
                 e['totalAyah'],
              ))
          .toList();
      return surahList;
    } catch (e) {
      return [];
    }
  }

  Future<List<AyahTranslation>> getSurah(int surah) async {
  try {
    final response = await _dio.get('https://quranapi.pages.dev/api/$surah.json');
    final data = response.data as Map<String, dynamic>;
    final dataList = (data['english'] as List).map((e) => AyahTranslation(e.toString())).toList();
    return dataList;
  } catch (e) {
    debugPrint('Error fetching surah: $e');
    throw Exception('Failed to fetch surah');
  }
}
}
