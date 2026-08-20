import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/setting_screen/presentation/controler/cubit/setting_cubit.dart';
import 'package:social_app/features/sign_up_screen/presentation/controler/sign_up_cubit.dart';
import 'package:social_app/features/sign_up_screen/presentation/ui_screen/sign_up.dart';
import 'package:social_app/features/social_layout/presentaion/controler/cubit/social_layout_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(  create: 
    (context) => SocialLayoutCubit())
   , BlocProvider(create:(context) => SignUpCubit(),
    ),
    BlocProvider(create:(context) => SettingCubit(),
    )
    ],
     child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: SignUp(),
    );
  }
}
