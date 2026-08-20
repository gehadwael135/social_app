import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/widgets/custom_button.dart';
import 'package:social_app/core/utils/widgets/custom_text_field.dart';
import 'package:social_app/features/sign_in_screen/presentation/ui_screen/sign_in.dart';
import 'package:social_app/features/sign_up_screen/presentation/controler/sign_up_cubit.dart';
import 'package:social_app/features/sign_up_screen/presentation/controler/sign_up_state.dart';
import 'package:social_app/features/social_layout/presentaion/ui_screen/social_layout.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //  var width=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Form(
        key: _key,
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
          body: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is CreatUserSuccess) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SocialLayout()),
                );
              }
              if (state is SignUpError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Sign Up is Faluire")));
              }
              if (state is CreatUserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Create user is Faluire")),
                );
              }
            },
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                children: [
                  SizedBox(height: height * 0.05),
                  CustomTextField(
                    label: 'User Name',
                    text: "e.g:Ahmed",
                    icon: Icons.person,
                    controller: nameController,
                  ),
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
                    passwordIcon: IconButton(
                      onPressed: () {
                        context.read<SignUpCubit>().changeScure();
                      },
                      icon: context.read<SignUpCubit>().isScure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required";
                      }
                      if (value.length < 6) {
                        return " Password must be at least 6 characters";
                      }

                      return null;
                    },
                    obscureText: !context.read<SignUpCubit>().isScure,
                  ),
                  SizedBox(height: height * 0.04),
                  CustomTextField(
                    label: 'Confirm Password',
                    text: "e.g:123456",
                    icon: Icons.password,
                    passwordIcon: IconButton(
                      onPressed: () {
                        context.read<SignUpCubit>().scureConfirmPassword();
                      },
                      icon: context.read<SignUpCubit>().isScureConfirmPassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),

                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required";
                      }
                      if (value != passwordController.text) {
                        return " Passwords do not match";
                      }

                      return null;
                    },
                    obscureText: !context
                        .read<SignUpCubit>()
                        .isScureConfirmPassword,
                  ),
                  SizedBox(height: height * 0.04),
                  state is SignUpLoading
                      ? Center(child: CircularProgressIndicator())
                      : cutomButton(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              print("sign up is done");

                              context.read<SignUpCubit>().signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                              );
                            }
                          },
                        ),
                  Row(
                    mainAxisAlignment: .center,

                    children: [
                      Text("Do you have an account?"),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
