// ignore_for_file: file_names, unused_import, prefer_const_constructors

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class feedback extends StatefulWidget {
  @override
  _feedbackState createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  List<bool> isTypeSelected = [false, false, false, true];
final TextEditingController textEditingController =TextEditingController();
final TextEditingController emailEditingController =TextEditingController();
String uploadImageText = "Upload screenshot (optional)";

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  Future<void> _checkPermission() async {
    if (await Permission.photos.isDenied) {
      await _requestPermission();
    }
  }

  Future<void> _requestPermission() async {
    final status = await Permission.photos.request();
    if (status.isDenied) {
    }
  }
List<String> _attachmentPaths = [];

  Future<void> _pickAndAttachFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _attachmentPaths.add(result.files.single.path!);
      });
    }
  }

  Future<void> _sendEmail() async {
    final Email email = Email(
      body: "${textEditingController.text}\n Feedback detalist: $isTypeSelected",
      subject: 'Feedback from ${emailEditingController.text}',
      recipients: ["develop.team.m2@gmail.com","mehrobjonabdulvahobov@gmail.com"],
      attachmentPaths: _attachmentPaths,
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
      debugPrint(platformResponse);
      
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        elevation: 2.0,
        centerTitle: true,
        title: Text(
          "Feedback",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Please select the type of the feedback",
              style: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
            ),
            SizedBox(height: 25.0),
            GestureDetector(
              child: buildCheckItem(
                  title: "Login trouble", isSelected: isTypeSelected[0]),
              onTap: () {
                if(isTypeSelected[0]==isTypeSelected[2]||isTypeSelected[0]==isTypeSelected[1]||isTypeSelected[0]==isTypeSelected[3]){
                setState(() {
                  isTypeSelected[0] = !isTypeSelected[0];
                });}
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "Personal profile", isSelected: isTypeSelected[1]),
              onTap: () {
                if(isTypeSelected[1]==isTypeSelected[0]||isTypeSelected[1]==isTypeSelected[2]||isTypeSelected[1]==isTypeSelected[3]){
                setState(() {
                  isTypeSelected[1] = !isTypeSelected[1];
                });}
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "Other issues", isSelected: isTypeSelected[2]),
              onTap: () {
                if(isTypeSelected[2]==isTypeSelected[0]||isTypeSelected[2]==isTypeSelected[1]||isTypeSelected[2]==isTypeSelected[3]){
                setState(() {
                  isTypeSelected[2] = !isTypeSelected[2];
                });}
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "Suggestions", isSelected: isTypeSelected[3]),
              onTap: () {
                if(isTypeSelected[3]==isTypeSelected[0]||isTypeSelected[3]==isTypeSelected[1]||isTypeSelected[3]==isTypeSelected[2]){
                  setState(() {
                  isTypeSelected[3] = !isTypeSelected[3];
                });}
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            buildFeedbackForm(),
            SizedBox(height: 20.0),
            buildEmailField(),
            Spacer(),
            Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red),
  ),
                  onPressed: () {
                  _sendEmail();
                  },
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildEmailField() {
    return  TextField(
      controller: emailEditingController,
      style: TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0.0),
        prefixIcon: Icon(Icons.email,color: Colors.red,),
        hintStyle: TextStyle(
          fontSize: 14.0,
          color: Color(0xFFC5C5C5),
        ),
        hintText: "Email",
        border: OutlineInputBorder(),
      ),
      
    );
  }

 
  buildFeedbackForm() {
    return  Container(
      height: 200,
      child: Stack(
        children: [
          TextField(
          controller: textEditingController,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: "Please briefly describe the issue",
              hintStyle: TextStyle(
                fontSize: 13.0,
                color: Color(0xFFC5C5C5),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFE5E5E5),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                    color: Color(0xFFA6A6A6),
                  ),
                ),
              ),
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                         icon:const Icon( Icons.add,
                        color: Color(0xFFA5A5A5),), 
                        onPressed: () {
                         if (textEditingController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Добавьте описание!",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.black,
        fontSize: 16,
        backgroundColor: Colors.grey[200],
      );
    } else {
      _pickAndAttachFile();
      setState(() {
        uploadImageText = "File added";
      });
    }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    uploadImageText,
                    style: TextStyle(
                      color: Color(0xFFC5C5C5),
                    ),
                  ),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCheckItem({required String title, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle,
            color: isSelected ? Colors.red : Colors.grey,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.red : Colors.grey),
          ),
        ],
      ),
    );
  }
}