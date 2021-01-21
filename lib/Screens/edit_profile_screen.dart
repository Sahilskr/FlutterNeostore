import 'dart:convert';
import 'dart:io';

import 'package:NeoStore/Api/api_provider.dart';
import 'package:NeoStore/Screens/cart_screen.dart';
import 'package:NeoStore/Screens/home_screen.dart';
import 'package:NeoStore/SharedPref/sharedprefs.dart';
import 'package:NeoStore/models/edit_profile_response.dart';
import 'package:NeoStore/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  String image = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  String _fname, _lname, _email, _phone, _bday;
  String access_token;
  DateTime date;
  File myimage;
  bool edit = false;
  String upload_image = "";
  final imagepicker = ImagePicker();
  TextEditingController _birthday = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchUser();
  }

  @override
  void dispose() {
    super.dispose();
    _birthday = new TextEditingController();
  }

  fetchUser() async {
    User user = await SharedPref().getUser();
    if (user != null) {
      setState(() {
        access_token = user.accessToken;
        if (user.image != null && user.image.length > 0) {
          image = user.image;
        }
        if (user.bday != null) {
          _birthday.text = user.bday;
          _bday = user.bday;
        }
      });
    }
  }

  Future getImage() async {
    final pickedImage = await imagepicker.getImage(source: ImageSource.gallery);

    final bytes = await pickedImage.readAsBytes();

    setState(() {
      if (pickedImage != null && bytes.length > 0) {
        myimage = File(pickedImage.path);
        edit = true;
        upload_image =
        "data:image/jpg;base64,${base64Encode(myimage.readAsBytesSync())}";
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w900)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          )
        ],

      ),
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(90.0),
                child: InkWell(
                  onTap: () {
                    print("Tapped");
                    getImage();
                  },
                  child: Image(
                    width: 180,
                    height: 180,
                    image: edit == false ? NetworkImage(image) : FileImage(
                        myimage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              editProfileForm(),
            ],
          ),
        ],
      ),
    );
  }

  editProfileForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 40),
      child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your First Name',
                  labelText: 'First Name',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'First Name is Required';
                  } else
                    return null;
                },
                onSaved: (String value) {
                  _fname = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your Last Name',
                  labelText: 'Last Name',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Last Name is Required';
                  } else
                    return null;
                },
                onSaved: (String value) {
                  _lname = value;
                },
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.email),
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Email is Required';
                    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Incorrect Email Type';
                    } else
                      return null;
                  },
                  onSaved: (String value) {
                    _email = value;
                  },
                  keyboardType: TextInputType.emailAddress),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.phone),
                  hintText: 'Enter your Phone Number',
                  labelText: 'Phone',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Phone is Required';
                  } else
                    return null;
                },
                onSaved: (String value) {
                  _phone = value;
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.cake),
                  hintText: 'Enter your Phone Number',
                  labelText: 'Birthday',
                ),
                controller: _birthday,
                onTap: () async {
                  // Below line stops keyboard from appearing
                  FocusScope.of(context).requestFocus(new FocusNode());

                  final datePick = await showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime(1900),
                      lastDate: new DateTime(2100));
                  if (datePick != null && datePick != date) {
                    setState(() {
                      date = datePick;

                      // put it here
                      _bday = "${date.day}-${date.month}-${date.year}"; // 08/14/2019
                      _birthday.text = _bday;
                    });
                    print(_birthday);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), side: BorderSide(color: Colors.teal)),
                    color: Colors.teal,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();

                      if (edit == true) {
                        ApiProvider()
                            .editprofile(_fname, _lname, _email, _phone, upload_image, _bday)
                            .then((val) {
                          if (val.status.toString() == "200") {
                            Data data = val.data;
                            String name= data.firstName+" "+data.lastName;

                            SharedPref().set(data.firstName,data.lastName,data.email,data.profilePic,data.dob,data.accessToken);
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                HomeScreen(name: name, email: data.email,image: data.profilePic,)), (Route<dynamic> route) => false);
                            Fluttertoast.showToast(
                                msg: val.userMsg,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                            );
                          }
                        }).catchError((error, stackTrace) {
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
                        Fluttertoast.showToast(msg: "Edit Image");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

