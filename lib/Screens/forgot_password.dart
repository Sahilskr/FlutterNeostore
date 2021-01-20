import 'package:NeoStore/Api/api_provider.dart';
import 'package:NeoStore/Screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      obscureText: false,
      autofocus: true,
      style: style,
      autovalidate: true,
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
        EmailValidator(errorText: "Enter valid email id"),
      ]),
      controller: _emailController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 15.0),
          hintText: "Enter your Email",
          labelText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );


    final SubmitButon = Material(

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
          ApiProvider().forgotPass(_emailController.text)
              .then((value) {
            Fluttertoast.showToast(
              msg: value,
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.teal,
              textColor: Colors.white,

            );
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));

          }).catchError((error,stacktrace){
            Fluttertoast.showToast(
              msg: error["user_msg"],
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,

            );
          });
        },
        child: Text("Submit",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: ListView(
        children: [
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
          SizedBox(height: 65.0),
          emailField,
          SizedBox(
            height: 35.0,
          ),
          SubmitButon,
        ],
      ),
    );
  }
}
