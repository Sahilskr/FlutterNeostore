import 'package:NeoStore/Bloc/SessionBloc/session_events.dart';
import 'package:NeoStore/Bloc/SessionBloc/session_states.dart';
import 'package:NeoStore/SharedPref/sharedprefs.dart';
import 'package:NeoStore/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionBloc extends Bloc<SessionEvent, SessionStates> {
  SessionBloc() : super(SessionInitial());

  @override
  Stream<SessionStates> mapEventToState(SessionEvent event) async* {
    if (event is AppStarted) {
      bool status = false;

      try {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String value = prefs.getString('access_token') ?? '';
        if (value.isEmpty) {
          status = false;
        } else {
          status = true;
        }

        if (status == true) {
          User user=await SharedPref().getUser();

          yield AuthSuccessful(name: user.fname+" "+user.lname,email: user.email);
        } else {
          yield UnAuthState();
        }
      } catch (e) {
        yield UnAuthState();
      }
    }
  }
}