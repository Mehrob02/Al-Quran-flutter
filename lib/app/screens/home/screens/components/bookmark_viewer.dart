// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, sized_box_for_whitespace, unused_local_variable, unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itube/app/screens/home.dart';
import 'package:itube/app/screens/home/pages/bookMarksPage.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/reader.dart';
import 'package:itube/my_test/mytestfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkBuilder extends StatefulWidget {
  const BookmarkBuilder({super.key, required this.bookmarkItem, required this.mark, required this.onDelete});
  final List <String> bookmarkItem;
  final String mark;
  final Function(String, String) onDelete;
  @override
  State<BookmarkBuilder> createState() => _BookmarkBuilderState();
}

class _BookmarkBuilderState extends State<BookmarkBuilder> {
  bool _isDeleted=false;
  
 Future _setBookmakJson() async{
    var prefs = await  SharedPreferences.getInstance();
    prefs.setString("bookmakJson", jsonString);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
     // decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: () {
  // int indexToScroll = int.parse(widget.bookmarkItem[1]);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => reader(
        widget.bookmarkItem[0],
        ayahs[surahs.indexOf(widget.bookmarkItem[0])],
        0,
      ),
    ),
  );
 
},
        child: Visibility(
          visible: !_isDeleted,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                     Padding(
                       padding: EdgeInsets.all(4.0),
                       child: Icon(
                          Icons.bookmark,
                          color: bookMarkColors[marks.indexOf(widget.mark)],
                        ),
                     ),
                      Text(
                        "${"Surah " + widget.bookmarkItem[0]} ayah " + widget.bookmarkItem[1],
                        
                        overflow: TextOverflow.ellipsis,
                        maxLines: 20,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
          setState(() {
             setState(() {
      widget.onDelete(widget.bookmarkItem[0], widget.bookmarkItem[1]);
    });
            _setBookmakJson();
           // _isDeleted=true;
          });
                },
                    icon: Icon(Icons.delete_outline),
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}