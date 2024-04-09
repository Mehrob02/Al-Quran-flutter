import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itube/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/registration_screens/components/my_textfield.dart';

import '../../../main.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
    final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  bool signInRequired = false;
  IconData iconPassword=CupertinoIcons.eye_fill;
  bool obscurePassword=true;
  String? _errorMsg;
 Future <void> resetPassword()async{
  await showDialog(context: context, builder:(BuildContext context) {
     return AlertDialog(
      title:Text("Reset Password"),
     content:Column(mainAxisSize:MainAxisSize.min,
     children:[
      TextField(
        controller: resetPasswordController,
      ),
      ElevatedButton(
        onPressed: () async {
          if(resetPasswordController.text.isEmpty){
            debugPrint("a");
              }else if(!RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])').hasMatch(resetPasswordController.text)){
                debugPrint("b");
              }else{
               debugPrint("c"); 
               try {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: resetPasswordController.text);     
} catch (e) {
  print('Error sending email $e');
}
                Navigator.pop(context);
              }
             
          }, 
          child:Text('OK')
        )
      ]));
  },);
 }
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
			listener: (context, state) {
				if(state is SignInSuccess) {
					setState(() {
					  signInRequired = false;
					});
				} else if(state is SignInProcess) {
					setState(() {
					  signInRequired = true;
					});
				} else if(state is SignInFailure) {
					setState(() {
					  signInRequired = false;
						_errorMsg = 'Invalid email or password';
					});
				}
			},
			child:  Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MyTextField(
            controller: emailController, 
            hintText: "Email", 
        //    text: "userdrive2005@gmail.com",
            obscureText: false,
             keyboardType: TextInputType.emailAddress,
             preffixIcon: const Icon(CupertinoIcons.mail_solid),
             errorMsg: _errorMsg,
             validator: (val){
              if(val!.isEmpty){
 return "ENTER EMAIL!!!";
              }else if(!RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])').hasMatch(val)){
return "ENTER Valid EMAIL!!!";
              }
             return null;
             },),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MyTextField(
            controller: passwordController, 
           // text: "Mahmudjon4!", //temp pass for testing purposes
            hintText: "Password", 
            obscureText: obscurePassword,
             keyboardType: TextInputType.visiblePassword,
             preffixIcon: const Icon(CupertinoIcons.padlock_solid),
             errorMsg: _errorMsg,
             validator: (val){
              if(val!.isEmpty){
 return "ENTER Password!!!";
              }else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)){
return "ENTER Valid Password!!!";
              }
             return null;
             },
             suffixIcon: IconButton(
             onPressed:(){ setState((){
               obscurePassword=!obscurePassword;
               if(obscurePassword){
                iconPassword=CupertinoIcons.eye_fill;
               }else{
                iconPassword=CupertinoIcons.eye_slash_fill;
               }
             });},
             icon: Icon(iconPassword)
              ),
             ),
          ),
        const SizedBox(height: 20),
        TextButton(onPressed: (){
          resetPassword();
        }, child: Text("forgot the password?")),
        const SizedBox(height: 5),
          !signInRequired 
          ?SizedBox(
            width: MediaQuery.of(context).size.width*0.5,
            child:  TextButton(
              onPressed: (){
              if(_formKey.currentState!.validate()){
                context.read<SignInBloc>().add(SignInRequired(
                emailController.text,
                passwordController.text,
                ));
              }
              },
              style: TextButton.styleFrom(
                elevation: 3.0,
backgroundColor: Colors.red,
foregroundColor: Colors.white,
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(60)
)
              ),
               child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                child: Text("Sign In", textAlign: TextAlign.center,),
                )),
          ):const CircularProgressIndicator()
        ],
      ),
      ));
  }
}