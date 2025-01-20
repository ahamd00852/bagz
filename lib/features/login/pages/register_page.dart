import 'package:bagz/core/widgets/text_feild.dart';
import 'package:bagz/features/login/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController=TextEditingController();
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
                        325.verticalSpace,
                        const Text('Register',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
                        10.verticalSpace,
                        TextFormFieldd(textFormName: 'FullName',validator: (text){
                          if(text!=null && text.length>=3){
                            return null;}
                          else {
                            return'Please Add A Valid Name';
                          }
                        }, controller: nameController),
                        10.verticalSpace,
                        TextFormFieldd(textFormName: 'Email',validator: (text){
                          if(text!=null && text.length>=6){
                            return null;}
                          else {
                            return'Please Add A Valid Email';
                          }
                        }, controller: emailController),
                        10.verticalSpace,
                        TextFormFieldd(textFormName: 'Password',validator: (text){
                          if(text!=null && text.length>=6){
                            return null;}
                          else {
                            return'Please Add A Valid Password';
                          }
                        }, controller: passwordController),
                        60.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap:()async{
                                if(isLoading==false) {
                                    if (formKey.currentState!.validate()) {
                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        final credential = await FirebaseAuth
                                            .instance
                                            .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Scaffold(
                                                      body: Center(
                                                        child: Text('Home'),
                                                      ),
                                                    )));
                                      } on FirebaseAuthException catch (e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        if (e.code == 'weak-password') {
                                          print(
                                              'The password provided is too weak.');
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          print(
                                              'The account already exists for that email.');
                                        }
                                      } catch (e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        print(e);
                                      }
                                    }
                                  }
                                } ,
                              child: Container(
                                height: 60,
                                width: 140,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white
                                    )
                                ),
                                child: Center(child: Text(isLoading?'Loading...':'Register',style: const TextStyle(color: Colors.white,fontSize: 24),)),
                              ),
                            )
                          ],),
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                            },
                            child: const Text('Login',style: TextStyle(fontSize: 20,color: Colors.white),))
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
