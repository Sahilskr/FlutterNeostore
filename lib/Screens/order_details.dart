import 'package:NeoStore/Api/api_provider.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
  final int id;
  OrderDetails({Key key, @required this.id})
      : super(key: key);
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900)),
        centerTitle: true,

      ),
      body: FutureBuilder(
        future: ApiProvider().orderDetail(widget.id),
        builder: (context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.none &&
    snapshot.hasData == null) {
    return Center(
    child: CircularProgressIndicator(),
    );
    } else if (snapshot.hasError) {
      print(snapshot.error);
    return Center(
    child: Text("DATA NOT FOUND"),
    );
    } else if (snapshot.hasData) {
      var value = snapshot.data;
      return Column(
        children: [
          Card(
            elevation: 7,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemCount: value.data.orderDetails.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      height: 90,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width *
                                0.77,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  value.data.orderDetails[index].prodImage,
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
                                      value.data.orderDetails[index].prodName,
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
                                        value.data.orderDetails[index].prodCatName,
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "₹ " +
                                value.data.orderDetails[index].total
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
                  "₹ " + value.data.cost.toString() + "/-",
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
        ],
      );
    }
    else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }

        },
      ),
    );
  }
}
