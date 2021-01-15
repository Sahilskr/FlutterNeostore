import 'package:NeoStore/Api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();

}

class _CartScreenState extends State<CartScreen> {



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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen()));

            },
          )
        ],

      ),
      body: FutureBuilder(
          future: ApiProvider().listCart(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("NOT FOUND"),
              );
            } else if (snapshot.hasData) {
              var value = snapshot.data;
              if (value.data == null) {
                return Container(
                  child: Center(
                    child: Text(
                      "Cart Empty...",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.teal
                      ),
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  Card(
                    elevation: 7,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                        itemCount: value.data.length,
                        itemBuilder: (context, index) {
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
                                      title: const Text("Delete Confirmation"),
                                      content: const Text("Are you sure you want to delete this item from your cart?"),
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
                              ApiProvider().deleteCart( value.data[index].productId)
                                  .then((val) {
                                Fluttertoast.showToast(
                                  msg: val.userMsg,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                );
                                setState(() {

                                });
                              }).catchError((error, stacktrace) {
                                print(error["user_msg"]);
                                Fluttertoast.showToast(
                                  msg: error["user_msg"],
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,

                                );
                                setState(() {

                                });
                              });

                            },
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                child: Container(
                                  height: 90,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.78,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Image.network(
                                              value.data[index].product
                                                  .productImages,
                                              height: 70,
                                              width: 90,
                                              fit: BoxFit.fitWidth,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  value.data[index].product.name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text("Category -" +
                                                    value.data[index].product
                                                        .productCategory),
                                                EditQuantity(value.data[index].quantity,value.data[index].productId),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "₹ " +
                                            value.data[index].product.subTotal
                                                .toString() +
                                            "/-",
                                        style: TextStyle(
                                          color: Colors.teal.shade700,
                                          fontSize: 15,
                                          backgroundColor: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        tileColor: Colors.tealAccent.shade100,
                        title: Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        trailing: Text(
                          "₹ " + value.total.toString() + "/-",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.teal,
                      child: MaterialButton(
                        minWidth: 340,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  EditQuantity(quantity, productId) {
    List<String> _dropdown = ['Select','1','2','3','4','5','6','7','8'];
    String _selected=quantity.toString();
    return DropdownButton(
      value: _selected,
      onChanged: (newValue) {
        if(newValue=="Select"){
          Fluttertoast.showToast(
            msg: "Please Select a quantity",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }
        else {
          ApiProvider().editCart(
               productId, int.parse(newValue))
              .then((val) {
            Fluttertoast.showToast(
              msg: val.userMsg,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
            setState(() {

            });
          }).catchError((error, stacktrace) {
            print(error["user_msg"]);
            Fluttertoast.showToast(
              msg: error["user_msg"],
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,

            );
            setState(() {

            });
          });
        }

      },
      items: _dropdown.map((number) {
        return DropdownMenuItem(
          child: new Text(number),
          value: number,
        );
      }).toList(),
    );
  }
}
