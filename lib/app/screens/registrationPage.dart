// ignore_for_file: file_names, unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itube/blocs/authentification_bloc/authentification_bloc.dart';
import 'package:itube/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:itube/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:itube/app/screens/registration_screens/sign_in.dart';
import 'package:itube/app/screens/registration_screens/sign_up.dart';
class registrationPage extends StatelessWidget {
  const registrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyRegistrationPage()
      );
  }
  }
  
  class MyRegistrationPage extends StatefulWidget {

  @override
  State<MyRegistrationPage> createState() => _MyRegistrationPage();
  
  }

class _MyRegistrationPage extends State<MyRegistrationPage> with TickerProviderStateMixin{
  late TabController tabController;

   @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
       vsync: this
       );
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: SingleChildScrollView(
  child: SizedBox(
    height: MediaQuery.of(context).size.height,
    child:  Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(20,-1.2),
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red[600],
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-2.7,-1.2),
          child: Container(
            height: MediaQuery.of(context).size.width/1.5,
            width: MediaQuery.of(context).size.width/1.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink,
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(2.7,-1.2),
          child: Container(
            height: MediaQuery.of(context).size.width/1.4,
            width: MediaQuery.of(context).size.width/1.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 234, 174, 35),
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height/1.6,
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    unselectedLabelColor: Colors.white30,
                    labelColor: Colors.white,
                    tabs: [
                      Padding(
                        padding: EdgeInsets.all(8),
                      child: Text("Sign in", style: TextStyle(fontSize: 20),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                      child: Text("Sign up", style: TextStyle(fontSize: 20)),
                      )
                    ]
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        BlocProvider<SignInBloc>(
                        create: (context)=>SignInBloc(
                        userRepository:   context.read<AuthenticationBloc>().userRepository
                        ),
                        child: const SignIn(),
                        ),
                        BlocProvider<SignUpBloc>(
                        create: (context)=>SignUpBloc(
                        userRepository: context.read<AuthenticationBloc>().userRepository
                        ),
                        child: const SignUp(),
                        )
                      ]
                    )
                  )
                ],
              ),
            ),
          )
      ],
    )
    ),
),
    );
  }
 
  }