import 'package:NeoStore/Api/api_provider.dart';
import 'package:NeoStore/Database/db.dart';
import 'package:NeoStore/Screens/add_address.dart';
import 'package:NeoStore/Screens/cart_screen.dart';
import 'package:NeoStore/Screens/order_list.dart';
import 'package:NeoStore/SharedPref/sharedprefs.dart';
import 'package:NeoStore/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAddressList extends StatefulWidget {
  @override
  _MyAddressListState createState() => _MyAddressListState();
  final String email;
  MyAddressList({Key key, @required this.email})
      : super(key: key);
}

class _MyAddressListState extends State<MyAddressList> {
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

                    Expanded(
                      child: ListView.builder(
                          itemCount: add.length,
                          itemBuilder: (context,index){

                            return Dismissible(
                              background: Container(
                                color: Colors.redAccent,
                                child: Padding(
                                  padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.8,top: 5),
                                  child: Icon(Icons.delete),
                                ),


                              ),
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (DismissDirection direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.tealAccent,
                                      title: const Text("Delete Confirmation"),
                                      content: const Text("Are you sure you want to delete this address?"),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text("Delete")
                                        ),
                                        FlatButton(
                                          onPressed: () => Navigator.of(context).pop(false),
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    );
                                  },
                                );

                              },
                              onDismissed: (DismissDirection direction){
                                final database=AppDatabase.getDatabase();
                                database.deleteAdd(add[index]);

                              },
                              child:   InkWell(
                                onTap: (){

                            },
                            child: Card(
                            elevation: 5,
                            child: ListTile(
                            isThreeLine: true,
                            title: Text("Address ${index+1}"),
                            subtitle: Text(add[index].address),


                            ),
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
