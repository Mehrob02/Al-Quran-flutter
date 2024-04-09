import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itube/app/screens/registration_screens/components/my_textfield.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
	final passwordController = TextEditingController();
  final emailController = TextEditingController();
	final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
	IconData iconPassword = CupertinoIcons.eye_fill;
	bool obscurePassword = true;
	bool signUpRequired = false;

	bool containsUpperCase = false;
	bool containsLowerCase = false;
	bool containsNumber = false;
	bool containsSpecialChar = false;
	bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
			listener: (context, state) {
				if(state is SignUpSuccess) {
					setState(() {
					  signUpRequired = false;
					});
					// Navigator.pop(context);
				} else if(state is SignUpProcess) {
					setState(() {
					  signUpRequired = true;
					});
				}  else if(state is SignUpFailure) {
					return;
				} 
			},
			child: Form(
						key: _formKey,
						child: Center(
							child: Column(
								children: [
									const SizedBox(height: 20),
									SizedBox(
										width: MediaQuery.of(context).size.width * 0.9,
										child: MyTextField(
											controller: emailController,
											hintText: 'Email',
											obscureText: false,
											keyboardType: TextInputType.emailAddress,
											preffixIcon: const Icon(CupertinoIcons.mail_solid),
											validator: (val) {
												if(val!.isEmpty) {
													return 'Please fill in this field';													
												} else if(!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
													return 'Please enter a valid email';
												}
												return null;
											}
										),
									),
									const SizedBox(height: 10),
									SizedBox(
										width: MediaQuery.of(context).size.width * 0.9,
										child: MyTextField(
											controller: passwordController,
											hintText: 'Password',
											obscureText: obscurePassword,
											keyboardType: TextInputType.visiblePassword,
											preffixIcon: const Icon(CupertinoIcons.lock_fill),
											onChanged: (val) {
												if(val!.contains(RegExp(r'[A-Z]'))) {
													setState(() {
														containsUpperCase = true;
													});
												} else {
													setState(() {
														containsUpperCase = false;
													});
												}
												if(val.contains(RegExp(r'[a-z]'))) {
													setState(() {
														containsLowerCase = true;
													});
												} else {
													setState(() {
														containsLowerCase = false;
													});
												}
												if(val.contains(RegExp(r'[0-9]'))) {
													setState(() {
														containsNumber = true;
													});
												} else {
													setState(() {
														containsNumber = false;
													});
												}
												if(val.contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
													setState(() {
														containsSpecialChar = true;
													});
												} else {
													setState(() {
														containsSpecialChar = false;
													});
												}
												if(val.length >= 8) {
													setState(() {
														contains8Length = true;
													});
												} else {
													setState(() {
														contains8Length = false;
													});
												}
												return null;
											},
											suffixIcon: IconButton(
												onPressed: () {
													setState(() {
														obscurePassword = !obscurePassword;
														if(obscurePassword) {
															iconPassword = CupertinoIcons.eye_fill;
														} else {
															iconPassword = CupertinoIcons.eye_slash_fill;
														}
													});
												},
												icon: Icon(iconPassword),
											),
											validator: (val) {
												if(val!.isEmpty) {
													return 'Please fill in this field';			
												} else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
													return 'Please enter a valid password';
												}
												return null;
											}
										),
									),
									const SizedBox(height: 10),
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceEvenly,
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											Column(
											crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text(
														"⚈  1 uppercase",
														style: TextStyle(
                              
															color: containsUpperCase
																? Colors.green
                                :Colors.red,
														),
													),
													Text(
														"⚈  1 lowercase",
														style: TextStyle(
                              
															color: containsLowerCase
																? Colors.green :Colors.red,
														),
													),
													Text(
														"⚈  1 number",
														style: TextStyle(
                              
															color: containsNumber
																? Colors.green
                                :Colors.red,
														),
													),
												],
											),
											Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text(
														"⚈  1 special character",
														style: TextStyle(
                              
															color: containsSpecialChar
																? Colors.green
                                :Colors.red,
														),
													),
													Text(
														"⚈  8 minimum character",
														style: TextStyle(
															color: contains8Length
																? Colors.green
                                :Colors.red,
														),
													),
												],
											),
										],
									),
									const SizedBox(height: 10),
									SizedBox(
										width: MediaQuery.of(context).size.width * 0.9,
										child: MyTextField(
											controller: nameController,
											hintText: 'Name',
											obscureText: false,
											keyboardType: TextInputType.name,
											preffixIcon: const Icon(CupertinoIcons.person_fill),
											validator: (val) {
												if(val!.isEmpty) {
													return 'Please fill in this field';													
												} else if(val.length > 30) {
													return 'Name too long';
												}
												return null;
											}
										),
									),
									SizedBox(height: MediaQuery.of(context).size.height * 0.02),
									!signUpRequired
										? SizedBox(
												width: MediaQuery.of(context).size.width * 0.5,
												child: TextButton(
													onPressed: () {
														if (_formKey.currentState!.validate()) {
															MyUser myUser = MyUser.empty;
															myUser = myUser.copyWith(
																email: emailController.text,
																name: nameController.text,
															);
															setState(() {
																context.read<SignUpBloc>().add(
																	SignUpRequired(
																		myUser,
																		passwordController.text
																	)
																);
															});																			
														}
													},
													style: TextButton.styleFrom(
														elevation: 3.0,
														backgroundColor: Theme.of(context).colorScheme.primary,
														foregroundColor: Colors.white,
														shape: RoundedRectangleBorder(
															borderRadius: BorderRadius.circular(60)
														)
													),
													child: const Padding(
														padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
														child: Text(
															'Sign Up',
															textAlign: TextAlign.center,
															style: TextStyle(
																color: Colors.white,
																fontSize: 16,
																fontWeight: FontWeight.w600
															),
														),
													)
												),
											)
										: const CircularProgressIndicator()
								],
							),
						),
				));
  }
}