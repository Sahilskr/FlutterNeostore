import 'package:NeoStore/Database/db.dart';
import 'package:NeoStore/Screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();

}

class _AddAddressState extends State<AddAddress> {
  final _addressController = TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final database = AppDatabase.getDatabase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address",
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartScreen()));
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height*0.87,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              child: TextFormField(
                controller: _addressController,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                validator: RequiredValidator(errorText: "* Required"),
                style: style,
                obscureText: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Add your address here",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.teal,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width / 1.5,
                    onPressed: ()async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String email = prefs.getString('email');

                      database.insertAdd(Add(address: _addressController.text, email: email))
                          .then((value){
                            print(value);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => CartScreen()));
                      });
                    },
                    child: Text(
                      "Save",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
