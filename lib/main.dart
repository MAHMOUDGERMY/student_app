import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:majles_app/SendNoty.dart';
import 'package:majles_app/cache/cashe_helper.dart';
import 'package:majles_app/comp.dart';
import 'package:majles_app/cubit/cubit.dart';
import 'package:majles_app/screens/choosefac.dart';
import 'package:majles_app/screens/home.dart';
import 'package:majles_app/screens/onbording.dart';
import 'cubit/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await DioHelper.init();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic('all');

  var onBording = await CacheHelper.getData(key: "OnBording");

  runApp(MyApp(onBoarding: onBording));
}

class MyApp extends StatelessWidget {
  final onBoarding;

  const MyApp({Key? key, this.onBoarding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitHome()
        ..getPosts()
        ..getData()
        ..getUserData(),
      child: BlocConsumer<CubitHome, HomeState>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: theme,
          darkTheme: darktheme,
          title: 'Majles',
          home: onBoarding == true ? Home() : OnBoarding(),
        ),
      ),
    );
  }
}
//working with git