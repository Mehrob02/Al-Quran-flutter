import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itube/Surahs/surahs.dart';
import 'package:flutter/material.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran/quran.dart';
class MyTest extends StatefulWidget{
  const MyTest({super.key, required this.page});
  final int page;
  @override
  State<MyTest> createState() => _MyTestState();
}

Widget surahViewer(int index, BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('surah_title/surah_${index+1}.png', color: Colors.grey,)),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: RichText(
                  textAlign: TextAlign.right,
                  text:TextSpan(
                  children: [
                    for(int i=0; i<ayahs[index]; i++)
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=(){
                        debugPrint((i+1).toString());
                      },
                      text:"${surahsMassive[index][i]} ${getVerseEndSymbol(i + 1)}",
                      
                      style: TextStyle(fontFamily: "Quran",color: Colors.white),
                      ),
                  ]
                )),
              ),
            ],
          ),
        ),
      ),
    );
}
class _MyTestState extends State<MyTest> {
  late int currentPage;
  late PageController pageController;

  @override
  void initState() {
    currentPage = widget.page;
    debugPrint((currentPage+1).toString());
    pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
  return Scaffold(
    body: Text(alBaqarah[4],style: TextStyle(fontSize: 33, fontFamily: "quran"),),
  );
    // return PageView.builder(
    //   controller: pageController,
    //   onPageChanged: (pageIndex) {
    //     setState(() => currentPage = pageIndex + 1);
    //     debugPrint("$currentPage");
    //   },
    //   padEnds: false,
    //   reverse: true,
    //   itemCount: 144,
    //   itemBuilder: (context, index){
    //    return surahViewer(index, context);
    //   });
  }
}
