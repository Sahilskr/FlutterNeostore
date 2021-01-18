import 'package:NeoStore/Api/api_provider.dart';
import 'package:NeoStore/Screens/cart_screen.dart';
import 'package:NeoStore/Screens/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
  final String category;
  final int id;

  ProductList({Key key, @required this.category, @required this.id})
      : super(key: key);
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category,
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
        future: ApiProvider().getProductList(widget.id),
        builder: (context, AsyncSnapshot snapshot)
            // {
            //   print(snapshot.hasData);
            //   print(snapshot.data);
            //   return Container(color: Colors.green,);
            // }
            {
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
            return ListView.builder(
              itemCount: value.data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetails(category:widget.category,productId: value.data[index].id,)));

                  },
                  child: Card(
                      child: Container(
                    height: 100,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.78,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                value.data[index].productImages,
                                height: 70,
                                width: 90,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    value.data[index].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(value.data[index].producer),
                                  SizedBox(height: 15,),
                                  Text("₹ "+value.data[index].cost.toString()+"/-",
                                  style: TextStyle(
                                    color: Colors.teal.shade700,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            SmoothStarRating(
                              allowHalfRating: false,
                              onRated: (v) {
                              },
                              starCount: 5,
                              rating: value.data[index].rating.toDouble(),
                              size: 15.0,
                              isReadOnly:true,
                              color: Colors.red,
                              borderColor: Colors.teal,
                              spacing:0.0
                          ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ),
                );
              },
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
