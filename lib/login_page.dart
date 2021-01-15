import 'package:NeoStore/home_screen.dart';
import 'package:NeoStore/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api/api_provider.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _key = new GlobalKey();
  final _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      obscureText: false,
      autofocus: true,
      style: style,
      // autovalidateMode: AutovalidateMode.always,
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
        EmailValidator(errorText: "Enter valid email id"),
      ]),
      controller: _emailController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 15.0),
          hintText: "Email",
          labelText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      // autovalidateMode: AutovalidateMode.always,
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
        MinLengthValidator(
            6, errorText: "Password should be atleast 6 characters"),
        MaxLengthValidator(
            15, errorText: "Password should not be greater than 15 characters")
      ]),
      controller: _passwordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 15.0),
          hintText: "Password",
          labelText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(

      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.teal,
      child: MaterialButton(
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // print(_emailController.text);
          if (_formKey.currentState.validate()) {
            print("Validated");
            ApiProvider()
                .login(_emailController.text, _passwordController.text)
                .then((value) {
              var msg = value.data.firstName + " " +
                  value.data.lastName;
                setAcessToken(value.data.accessToken);
              // print(msg);
              Fluttertoast.showToast(
                msg: "Welcome " + msg,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.teal,
                textColor: Colors.white,
              );
              Navigator.push(context, RegisterRoute(page: HomeScreen(name: msg,email: value.data.email,)));
            }).catchError((error, stacktrace) {
              print(error["user_msg"]);
              Fluttertoast.showToast(
                msg: error["user_msg"],
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,

              );
            });
          } else {
            print("Not Validated");
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );


    return Scaffold(
      key: _key,
      // appBar: AppBar(
      //
      //   title: Text("Neostore"),
      //   centerTitle: true,
      // ),
      body: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:36.0),
                child: Text("NeoSTORE",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 40,
                  letterSpacing: 4.0,
                  fontWeight: FontWeight.w900
                ),),
              ),),
            Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:EdgeInsets.only(left: 36,right: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 65.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButon,

                  ],
                ),
              ),
            ),
          ),
            Center(
              child: FlatButton(
                onPressed: () {

                },
                child: Text(
                    "Forgot Password?",
                    style: style.copyWith(
                      color: Colors.teal,
                      fontWeight: FontWeight.w900,)
                ),

              ),
            ),
            Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Dont have an account?",
                        style: style.copyWith(
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(context, RegisterRoute(page: RegisterScreen()));
                        },
                        child: Text(
                          "Sign up",
                          style: style.copyWith(
                            color: Colors.teal,
                            fontWeight: FontWeight.w900,)
                          ),

                        ),

                    ],
                  ),
                ),
            ),
          ]


      )
      ,
    );
  }

  setAcessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken);
    // print(prefs.getString('access_token'));
  }
}
class RegisterRoute extends PageRouteBuilder {
  final Widget page;
  RegisterRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        ),
  );
}


