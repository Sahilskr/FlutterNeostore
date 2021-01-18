import 'package:NeoStore/Api/api_provider.dart';
import 'package:NeoStore/Screens/cart_screen.dart';
import 'package:NeoStore/Screens/order_details.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 1.0,
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
      body: FutureBuilder(
        future: ApiProvider().listOrder(),
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
            if (value.data == null) {
              return Container(
                child: Center(
                  child: Text(
                    "No Orders!",
                    style: TextStyle(fontSize: 40, color: Colors.teal),
                  ),
                ),
              );
            }
            return ListView.builder(
                itemCount: value.data.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => OrderDetails(id: value.data[index].id)));
                    },
                    child: Card(
                      child: ListTile(
                        title: Text("Order id: "+value.data[index].id.toString()),
                        subtitle: Text("Ordered on: "+value.data[index].created),
                        trailing:   Text(
                          "₹ " +
                              value.data[index].cost
                                  .toString() +
                              "/-",
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
