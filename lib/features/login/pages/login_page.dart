import 'package:bagz/core/widgets/text_feild.dart';
import 'package:bagz/features/home/presentation/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
       child: Form(
         key: formKey,
         autovalidateMode: AutovalidateMode.always,
         child: Column(
           children: [
             SizedBox(
               child: Stack(children: [
                 Image.asset('assets/images/LoginB.png',
                 fit: BoxFit.cover,
                 height: 1.sh,
                 width: 1.sw,
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                     390.verticalSpace,
                     const Text('Login',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
                      10.verticalSpace,
                      TextFormFieldd(textFormName: 'Email',
                          validator: (text){
                          if(text !=null && text.length>=3){
                        return null;}
                          else{
                            return'Please Add A Valid Password';
                          }
                          },
                          controller: emailController),
                       19.verticalSpace,
                      TextFormFieldd(textFormName: 'Password',validator: (text){
                        if(text!=null && text.length>=6){
                        return null;}
                        else {
                          return'Please Add A Valid Password';
                        }
                        }, controller: passwordController),
                      120.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        GestureDetector(
                          onTap:()async{
                            if(isLoading==false) {
                                    if (formKey.currentState!.validate()) {
                                      try {
                                        setState(() {
                                          isLoading=true;
                                        });
                                        final credential = await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                        setState(() {
                                          isLoading=false;
                                        });
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                      } on FirebaseAuthException catch (e) {
                                        setState(() {
                                          isLoading=false;
                                        });
                                        if (e.code == 'user-not-found') {
                                          print(
                                              'No user found for that email.');
                                        } else if (e.code == 'wrong-password') {
                                          print(
                                              'Wrong password provided for that user.');
                                        }
                                      }
                                    }
                                  }
                                },
                          child: Container(
                            height: 60,
                            width: 140,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white
                            )
                            ),
                            child: Center(child: Text(isLoading?'Loading...':'Login',style: const TextStyle(color: Colors.white,fontSize: 24),)),
                          ),
                        )
                      ],)
                   ],),
                 )
               ],),
             ),
           ],
         ),
       ),
     ),
    );
  }
}
