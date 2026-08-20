import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/widgets/custom_button.dart';
import 'package:social_app/core/utils/widgets/custom_text_field.dart';
import 'package:social_app/features/sign_in_screen/presentation/controler/cubit/sign_in_cubit.dart';
import 'package:social_app/features/social_layout/presentaion/ui_screen/social_layout.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn > createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //  var width=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Form(
        key: _key,
        child: BlocProvider(
          create: (context) => SignInCubit(),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Sign in",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: BlocConsumer<SignInCubit, SignInState>(
              listener: (context, state) {
                
                if (state is SignInSuccess) {
                
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SocialLayout()),
                  );
                }
              
                if (state is SignInError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Sign In is Faluire")));
                }
               

              },
              builder: (context, state) {
                
  
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  children: [
                    SizedBox(height: height * 0.05),
                    
                    SizedBox(height: height * 0.04),
                    CustomTextField(
                      label: 'Email',
                      text: "e.g:Ahmed@gmail.com",
                      icon: Icons.email,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "this field is required";
                        }
                        if (!RegExp(
                          r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.04),

                    CustomTextField(
                      label: 'Password',
                      text: "e.g:123456",
                      icon: Icons.password,
                      passwordIcon: IconButton(onPressed: (){
                   context.read<SignInCubit>().changeScure();
                      }, icon: context.read<SignInCubit>().isScure?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                  
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "this field is required";
                        }
                      
                        return null;
                      },
                      obscureText:! context.read<SignInCubit>().isScure,
                    ),
                    SizedBox(height: height * 0.04),
                    
                    SizedBox(height: height * 0.04),
                    state is SignInLoading ? Center(child: CircularProgressIndicator(),):
                    
                    cutomButton(
                      child: Text("Sign In",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500)),
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          print("sign up is done");
                          
                          context.read<SignInCubit>().signIn(
                            email: emailController.text,
                            password: passwordController.text
                          );
                             }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}