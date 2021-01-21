import 'package:NeoStore/Api/api_provider.dart';
import 'package:NeoStore/Bloc/SessionBloc/session_bloc.dart';
import 'package:NeoStore/Screens/splash_screen.dart';
import 'package:NeoStore/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'Screens/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
      BlocProvider(
      create: (context) => SessionBloc(),
  ),
  ],
  child:  MyApp()
  ));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeosTore',
      theme: ThemeData(

        primarySwatch: Colors.teal,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(
        child: Text("NeoStores",
            style: TextStyle(
                color: Colors.teal,
                fontSize: 50,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w900)),
      ),
    );
  }
}


