import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/network/local/cashe_helper.dart';
import 'package:social_app/features/sign_up_screen/presentation/controler/sign_up_cubit.dart';
import 'package:social_app/features/sign_up_screen/presentation/ui_screen/sign_up.dart';
import 'package:social_app/features/social_layout/presentaion/controler/cubit/social_layout_cubit.dart';
import 'package:social_app/features/social_layout/presentaion/ui_screen/social_layout.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
 final isLoggedIn= CacheHelper.getCacheData(key: 'isLoggendIn');

 
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(  create: 
    (context) => SocialLayoutCubit())
   , BlocProvider(create:(context) => SignUpCubit(),
    ),
    ],
     child:  MyApp( isLoggedIn: isLoggedIn==true)),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(
    {super.key, required this.isLoggedIn});
 final bool isLoggedIn;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
        ),

      ),bottomNavigationBarTheme: BottomNavigationBarThemeData(

      ),
        colorScheme: .fromSeed(seedColor: Colors.blue)),

      home:isLoggedIn==true? SocialLayout():SignUp(),
    );
  }
}
