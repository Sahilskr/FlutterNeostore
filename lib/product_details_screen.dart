import 'package:NeoStore/Api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'cart_screen.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
  final String category;
  final int productId;

  ProductDetails({Key key, @required this.category, @required this.productId})
      : super(key: key);
}

class _ProductDetailsState extends State<ProductDetails> {
  String imge;
  int rate=3;

  void initState() {
    super.initState();
    imge = "";
    rate=3;
  }

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
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future: ApiProvider().getProductDetail(widget.productId),
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
                return Container(
                  height: MediaQuery.of(context).size.height*0.87,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        shadowColor: Colors.teal,
                        elevation: 3,
                        margin: EdgeInsets.only(left: 5.0, right: 5.0),
                        child: ListTile(
                          title: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: Text(
                              value.data.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Category- " +
                                widget.category +
                                "\n" +
                                value.data.producer),
                          ),
                          isThreeLine: true,
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: SmoothStarRating(
                                allowHalfRating: true,
                                onRated: (v) {},
                                starCount: 5,
                                rating: value.data.rating.toDouble(),
                                size: 20.0,
                                isReadOnly: true,
                                color: Colors.red,
                                borderColor: Colors.teal,
                                spacing: 0.0),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 12,
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        shadowColor: Colors.teal,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  "₹ " + value.data.cost.toString() + "/-",
                                  style: TextStyle(
                                    color: Colors.teal.shade700,
                                    fontSize: 35,
                                    fontWeight:FontWeight.w900,
                                    letterSpacing: 1,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.share,
                                  color: Colors.teal,
                                ),
                                dense: true,
                              ),
                              Center(
                                child: FadeInImage(
                                  image: NetworkImage(imge),
                                  placeholder: NetworkImage(
                                      value.data.productImages[0].image),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 400,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.data.productImages.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            imge = value.data
                                                .productImages[index].image;
                                          });
                                        },
                                        child: Card(
                                          elevation: 4,
                                          shadowColor: Colors.red,
                                          child: Image.network(
                                            value.data.productImages[index]
                                                .image,
                                            width: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Description:",style: TextStyle(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.8
                                    ..color = Colors.teal[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:8.0,bottom: 20),
                                child: Text(value.data.description,
                                  style: TextStyle(
                                    backgroundColor: Colors.teal.shade100,
                                    fontSize: 15,
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.teal,
                                child: MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2.3,
                                  onPressed: () {
                                    showDialog(
                                        context:context,
                                      builder: (context){
                                          final _quantityController=TextEditingController();
                                        return AlertDialog(
                                          title: Text(value.data.name),
                                          titleTextStyle: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          content: Container(
                                              height: 400,
                                              width: 300,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Image.network(value.data.productImages[0].image,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:18.0),
                                                  child: Center(
                                                    child: Text("Enter Quantity"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:8.0),
                                                  child: Center(
                                                    child: Container(
                                                      width: 40,
                                                      child: TextFormField(
                                                        cursorColor: Colors.teal,
                                                        controller: _quantityController,
                                                        keyboardType: TextInputType.number,
                                                        decoration: InputDecoration(
                                                            contentPadding: EdgeInsets.all(5),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:40.0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      Material(
                                                        elevation: 5.0,
                                                        borderRadius: BorderRadius.circular(30.0),
                                                        color: Colors.teal,
                                                        child: MaterialButton(
                                                          minWidth: 140,

                                                          onPressed: ()async {
                                                            String accessToken=await getAccessToken()  ?? "no token";
                                                            print(accessToken);
                                                            ApiProvider().addtoCart(accessToken, value.data.id,int.parse(_quantityController.text))
                                                                .then((val){
                                                              Fluttertoast.showToast(
                                                                msg: val.userMsg,
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                backgroundColor: Colors.black,
                                                                textColor: Colors.white,
                                                              );
                                                            }).catchError((error, stacktrace) {
                                                              Fluttertoast.showToast(
                                                                msg: error["user_msg"],
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.red,
                                                                textColor: Colors.white,

                                                              );
                                                            });
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            "Submit",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 25,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Material(
                                                        elevation: 5.0,
                                                        borderRadius: BorderRadius.circular(30.0),
                                                        color: Colors.grey,
                                                        child: MaterialButton(
                                                          minWidth: 140,
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 25,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ),
                                        );
                                      }
                                    );

                                  },
                                  child: Text(
                                    "Buy Now",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.amber,
                                child: MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2.3,
                                  onPressed: () {

                                    showDialog(
                                        context:context,
                                        builder: (context){
                                          final _quantityController=TextEditingController();
                                          return AlertDialog(
                                            title: Text(value.data.name),
                                            titleTextStyle: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            content: Container(
                                                height: 400,
                                                width: 300,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Image.network(value.data.productImages[0].image,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top:18.0),
                                                      child: Center(
                                                        child: Text("Rate this Product"),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top:8.0, bottom: 30),
                                                      child: Center(
                                                        child: SmoothStarRating(
                                                            allowHalfRating: true,
                                                            onRated: (v) {
                                                              setState(() {
                                                                rate=v.toInt();
                                                              });
                                                            },
                                                            starCount: 5,
                                                            rating: value.data.rating.toDouble(),
                                                            size: 40.0,
                                                            isReadOnly: false,
                                                            color: Colors.red,
                                                            borderColor: Colors.teal,
                                                            spacing: 0.0),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Material(
                                                        elevation: 5.0,
                                                        borderRadius: BorderRadius.circular(30.0),
                                                        color: Colors.teal,
                                                        child: MaterialButton(
                                                          minWidth: 140,
                                                          onPressed: () {
                                                            print(value.data.id);
                                                            print(rate);
                                                            ApiProvider()
                                                                .setRating(value.data.id, rate)
                                                                .then((val) {
                                                              Fluttertoast.showToast(
                                                                msg: val.userMsg,
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                backgroundColor: Colors.black,
                                                                textColor: Colors.white,
                                                              );

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
                                                            Navigator.pop(context);

                                                          },
                                                          child: Text(
                                                            "RATE",
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
                                                )
                                            ),
                                          );
                                        }
                                    );

                                  },
                                  child: Text(
                                    "Rate Now",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

    getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token');

    return token;
  }
}
