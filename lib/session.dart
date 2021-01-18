import 'package:NeoStore/Bloc/SessionBloc/session_bloc.dart';
import 'package:NeoStore/Bloc/SessionBloc/session_states.dart';
import 'package:NeoStore/Screens/home_screen.dart';
import 'package:NeoStore/Screens/login_page.dart';
import 'package:NeoStore/Screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/SessionBloc/session_events.dart';

class Session extends StatefulWidget {
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionBloc, SessionStates>(
        listener:  (context,states){
          if(states is SessionInitial){
            // print("state: Auth Initial");
            BlocProvider.of<SessionBloc>(context).add(AppStarted());
          }
        },
        // ignore: missing_return
        builder: (context, states){
          if(states is SessionInitial){
            BlocProvider.of<SessionBloc>(context).add(AppStarted());

            return SplashScreen();
          }
          if(states is AuthSuccessful){
            return HomeScreen(name: states.name, email: states.email);
          }
          if(states is UnAuthState){
            return LoginPage();
          }
        }

    );
  }
}
