
import 'package:NeoStore/Api/api_provider.dart';
import 'package:NeoStore/Bloc/SessionBloc/session_bloc.dart';
import 'package:NeoStore/Bloc/SessionBloc/session_events.dart';
import 'package:NeoStore/Screens/address_list.dart';
import 'package:NeoStore/Screens/cart_screen.dart';
import 'package:NeoStore/Screens/edit_profile_screen.dart';
import 'package:NeoStore/Screens/login_page.dart';
import 'package:NeoStore/Screens/order_list.dart';
import 'package:NeoStore/Screens/productlist_screen.dart';
import 'package:NeoStore/SharedPref/sharedprefs.dart';
import 'package:NeoStore/models/cart_response.dart';
import 'package:NeoStore/models/list_cart_response.dart';
import 'package:NeoStore/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  final String name, email,image;

  HomeScreen({Key key, @required this.name, @required this.email,this.image})
      : super(key: key);
}

class _HomeScreenState extends State<HomeScreen> {
  var images = [
    "assets/images/slider_img1.jpg",
    "assets/images/slider_img2.jpg",
    "assets/images/slider_img3.jpg",
    "assets/images/slider_img4.jpg"
  ];
  String image="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  @protected
  @mustCallSuper
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neostore",
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
      drawer: myNavigationDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(16.0),
                  color: Colors.teal,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Swiper(
                    autoplay: true,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                      );
                    },
                    pagination: SwiperPagination(builder: SwiperPagination.dots),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(category:"Tables",id: 1,)));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("assets/homeimages/tableicon.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(category:"Chairs",id: 2,)));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("assets/homeimages/chairsicon.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(category:"Cupboards",id: 4,)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/homeimages/cupboardicon.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(category:"Sofas",id: 3,)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/homeimages/sofaicon.png"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myNavigationDrawer(){
   return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                ClipOval(
                  child: Image.network(
                    widget.image??"https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Text(widget.name),
                Text(widget.email),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
          ),
          ListTile(
            title: Text('My Cart'),
            leading: Image.asset(
              "assets/icons/shopping_cart.png",
              color: Colors.black,
            ),
            onTap: ()async {

              String access_token=await getAccessToken()??"no token";
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen()));

            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 0.5,
          ),
          ListTile(
            hoverColor: Colors.blueAccent,
            title: Text('Tables'),
            leading: Image.asset(
              "assets/icons/tables_icon.png",
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(category:"Tables",id: 1,)));

            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 0.5,
          ),
          ListTile(
            hoverColor: Colors.blueAccent,
            title: Text('Sofas'),
            leading: Image.asset(
              "assets/icons/sofa_icon.png",
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(category:"Sofas",id: 4,)));

            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 0.5,
          ),
          ListTile(
            hoverColor: Colors.blueAccent,
            title: Text('Chairs'),
            leading: Image.asset(
              "assets/icons/chair_icon.png",
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(category:"Chairs",id: 2,)));

            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 0.5,
          ),
          ListTile(
            title: Text('Cupboards'),
            leading: Image.asset(
              "assets/icons/cupboard_icon.png",
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(category:"Cupboards",id: 3,)));

            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 0.5,
          ),

          ListTile(
            hoverColor: Colors.blueAccent,
            title: Text('Edit Profile'),
            leading: Image.asset(
              "assets/icons/username_icon.png",
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EditProfileScreen()));
            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 0.5,
          ),
          ListTile(
            hoverColor: Colors.blueAccent,
            title: Text('Store Locator'),
            leading: Image.asset(
              "assets/icons/storelocator_icon.png",
              color: Colors.black,
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 0.5,
          ),
          ListTile(
            hoverColor: Colors.blueAccent,
            title: Text('My Orders'),
            leading: Image.asset(
              "assets/icons/myorders_icon.png",
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => OrderList()));
            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 0.5,
          ),
          ListTile(
            hoverColor: Colors.blueAccent,
            title: Text('Logout'),
            leading: Image.asset(
              "assets/icons/logout_icon.png",
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  LoginPage()), (Route<dynamic> route) => false);
              SharedPref().clear();
              BlocProvider.of<SessionBloc>(context).add(AppStarted());
            },
          )
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
