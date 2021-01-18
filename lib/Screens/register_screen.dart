import 'package:NeoStore/Api/api_provider.dart';
import 'package:NeoStore/Screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';



class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<ScaffoldState> _key = new GlobalKey();
  final _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cnfpasswordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _agreedToTOS = true;

  int _radioValue=1;
  String choice="M";

  void radioButtonChanges(int value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 1:
          choice = "M";
          break;
        case 2:
          choice = "F";
          break;
        default:
          choice = "M";
      }
      debugPrint(choice); //Debug the choice in console
    });
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    _cnfpasswordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstName = TextFormField(
      obscureText: false,
      style: style,
      // autovalidateMode: AutovalidateMode.always,
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
      ]),
      controller: _firstnameController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final lastName = TextFormField(
      obscureText: false,
      style: style,
      // autovalidateMode: AutovalidateMode.always,
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
      ]),
      controller: _lastnameController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final phoneFiled = TextFormField(
      obscureText: false,
      style: style,
      keyboardType: TextInputType.number,
      // autovalidateMode: AutovalidateMode.always,
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
      ]),
      controller: _phoneController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Phone no",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final emailField = TextFormField(
      obscureText: false,
      style: style,
      // autovalidateMode: AutovalidateMode.always,
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
        EmailValidator(errorText: "Enter valid email id"),
      ]),
      controller: _emailController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      // autovalidateMode: AutovalidateMode.always,
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
        MinLengthValidator(6,
            errorText: "Password should be atleast 6 characters"),
        MaxLengthValidator(15,
            errorText: "Password should not be greater than 15 characters")
      ]),
      controller: _passwordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final confirmpasswordField = TextFormField(
      obscureText: true,
      style: style,
      // autovalidateMode: AutovalidateMode.always,
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
      ]),
      controller: _cnfpasswordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final submitButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.teal,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // ignore: unnecessary_statements
          if(_submittable()){
            _submit();
          }else{
            Fluttertoast.showToast(
              msg: "Please agreee to terms ",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
            );
          }

          // print(_emailController.text);
          // if (_formKey.currentState.validate()) {
          //   print("Validated");

        },
        child: Text("Submit",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    Widget back(){
      return Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );

    }

    return Scaffold(
      // backgroundColor: Colors.purpleAccent,
      key: _key,
      // appBar: AppBar(
      //
      //   title: Text("Neostore"),
      //   centerTitle: true,
      // ),
      body: ListView(children: <Widget>[
        Row(
          children: [
            back(),

            Padding(
                padding:  EdgeInsets.only(top: 10.0,left: MediaQuery.of(context).size.width*0.21),
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 30,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w900),
                ),
              ),

          ],
        ),

        Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 36, right: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  firstName,
                  SizedBox(height: 15.0),
                  lastName,
                  SizedBox(height: 15.0),
                  emailField,
                  SizedBox(height: 15.0),
                  passwordField,
                  SizedBox(height: 15.0),
                  confirmpasswordField,
                  SizedBox(height: 15.0),
                  phoneFiled,
                  SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: Row(

                      children: <Widget>[
                        Text(
                          "Gender :",
                          style: style.copyWith(
                              color: Colors.grey.shade700,
                          ),
                        ),
                        Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: radioButtonChanges,
                        ),
                        Text(
                          "M",
                        ),
                        Radio(
                          value: 2,
                          groupValue: _radioValue,
                          onChanged: radioButtonChanges,
                        ),
                        Text(
                          "F",
                        ),
                      ],
                    ),
                  ),


                   Row(
                    children: <Widget>[
                      Checkbox(
                        value: _agreedToTOS,
                        onChanged: _setAgreedToTOS,
                      ),
                      GestureDetector(
                        onTap: () => _setAgreedToTOS(!_agreedToTOS),
                        child: const Text(
                          'I agree to the Terms & conditions',
                        ),
                      ),
                    ],
                  ),

                  submitButton,
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      print('Form submitted');
        ApiProvider()
            .register(_firstnameController.text,_lastnameController.text, _emailController.text,
            _passwordController.text,_cnfpasswordController.text,choice,_phoneController.text).then((value) {
          print("sucessssssss");
          Fluttertoast.showToast(
            msg: value.userMsg,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green.shade700,
            textColor: Colors.white,
          );
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));

        }).catchError((error, stacktrace) {
          // print(error["user_msg"]);
          Fluttertoast.showToast(
            msg: error["user_msg"],
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        });

    }
    else {
      print("Not validated");
    }
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
