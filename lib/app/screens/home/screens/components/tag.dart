// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itube/main.dart';
import 'package:itube/app/screens/home/pages/bookMarksPage.dart';
import 'package:itube/app/screens/home.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/my_test/mytestfile.dart';
import 'package:itube/app/screens/home/screens/components/bookmark_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagBuilder extends StatefulWidget {
  const TagBuilder({super.key, required this.mark, required this.data, required this.removeFromTag});

  final String mark;
  final List data;
 final Function (String, String) removeFromTag;
  @override
  _TagBuilderState createState() => _TagBuilderState();
}

class _TagBuilderState extends State<TagBuilder> with  SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  bool _isVisible = true;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _heightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _initStateAsync();
  }
   void _initStateAsync() async{
  await translations.loadTranslations();
  }
   Future loadBookmakJson() async{
    jsonString = await _getBookmakJson();
  }

   Future<String> _getBookmakJson() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("bookmakJson")??jsonString;
  }
  Future<void> _setBookmakJson() async {
  var prefs = await SharedPreferences.getInstance();
  }
  //  void removeFromTag(String surah, String ayah) {
  //   Map<String, dynamic> jsonMap = json.decode(jsonString);

  //   jsonMap[widget.mark].removeWhere((mark) => mark[0] == surah && mark[1] == ayah);
  //   String updatedJsonString = json.encode(jsonMap);
    
  //   setState(() {
  //     jsonString = updatedJsonString;
  //     _setBookmakJson();
  //   });

  //   debugPrint(jsonString);
  // }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: bookMarkColors[marks.indexOf(widget.mark)%10],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.mark, textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w700),),
                  IconButton(
                    icon: Icon(!_isVisible? Icons.remove_circle_outline_sharp:Icons.arrow_drop_down_circle),
                    onPressed: () {
                      
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                      if (!_isVisible) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _heightAnimation,
            child: widget.data.isEmpty? Text(translations.translate("Nothing is here", currentLanguage)) : SizedBox(
              height:widget.data.length<=3? (MediaQuery.of(context).size.height*0.1*widget.data.length):(MediaQuery.of(context).size.height*0.1*3.5),
              child: ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return BookmarkBuilder(bookmarkItem: widget.data[index], mark: widget.mark,         
                  //    removeFromTag(widget.mark, widget.data[index][0], widget.data[index][1]);
                     onDelete: (surah, ayah) {
    widget.removeFromTag(surah, ayah);
    setState(() {
      
    });
  }, 
                  
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
