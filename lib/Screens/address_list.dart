import 'package:NeoStore/Api/api_provider.dart';
import 'package:NeoStore/Database/db.dart';
import 'package:NeoStore/Screens/add_address.dart';
import 'package:NeoStore/Screens/cart_screen.dart';
import 'package:NeoStore/Screens/order_list.dart';
import 'package:NeoStore/SharedPref/sharedprefs.dart';
import 'package:NeoStore/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
  final String email;
  AddressList({Key key, @required this.email})
      : super(key: key);
}

class _AddressListState extends State<AddressList> {
  final database=AppDatabase.getDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Adresses",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            iconSize: 30,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddAddress()));

            },
          )
        ],

      ),
      body: FutureBuilder(
        future: database.getAdds(widget.email),
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("DATA NOT FOUND"),
            );
          } else if (snapshot.hasData) {
            List<Add> add = snapshot.data;
            print(add);
            if (add.length == 0) {
              return Scaffold(

                floatingActionButton: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    splashRadius: 70,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(15),
                    color: Colors.teal,
                    highlightColor: Colors.redAccent,
                    focusColor: Colors.redAccent ,
                    splashColor: Colors.green,
                      iconSize: 55,
                      icon: Icon(Icons.add),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddAddress()));

                    },
                  ),
                ),
                body: Container(
                  child: Center(
                    child: Text(
                      "No Saved Adresses",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.teal
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Center(
                      child: Text("Select a Address",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.blueGrey,
                      ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: add.length,
                        itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            ApiProvider().order(add[index].address)
                                .then((val) {
                              Fluttertoast.showToast(
                                msg: val.userMsg,
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderList()));


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
                          },
                          child: Card(
                              elevation: 5,
                              child: ListTile(
                                isThreeLine: true,
                                title: Text("Address ${index+1}"),
                                subtitle: Text(add[index].address),


                              ),
                          ),
                        );
                        }),
                  ),
                ],
              ),
            );
          }
          else {
          return Center(
          child: CircularProgressIndicator(),
          );
          }
        }),
    );
  }


}
