import 'dart:convert';

import 'file:///C:/Users/user/IdeaProjects/NeoStore/lib/Screens/login_page.dart';
import 'package:NeoStore/models/cart_response.dart';
import 'package:NeoStore/models/list_cart_response.dart';
import 'package:NeoStore/models/login_response.dart';
import 'package:NeoStore/models/order_details_response.dart';
import 'package:NeoStore/models/order_list_response.dart';
import 'package:NeoStore/models/order_response.dart';
import 'package:NeoStore/models/product_details_response.dart';
import 'package:NeoStore/models/product_rating_response.dart';
import 'package:NeoStore/models/productlist_response.dart';
import 'package:NeoStore/models/register_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider{
  final String _baseurl="http://staging.php-dev.in:8844/trainingapp/api/";
  Dio _dio;

  ApiProvider(){
    BaseOptions options=
        BaseOptions(receiveTimeout: 10000,connectTimeout: 10000);
    _dio=Dio(options);
  }

  Future<ResponseLogin> login(String email,String password) async{
    String append="users/login";
    print(_baseurl+append);
    FormData formData=new FormData.fromMap({
      "email":email,
      "password":password,
    });
    try{
      Response response=await _dio.post(_baseurl+append,data: formData);
      var parse=json.decode(response.data);

      // print(response.data);
       //print(parse);
      return ResponseLogin.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      throw error;
      print(e.response.data);

    }
  }

  Future<RegisterResponse> register(String firstName,String lastName,String email,
      String password,String confirmPassword,String gender,String phoneNo) async{
    String append="users/register";
    print(_baseurl+append);
    FormData formData=new FormData.fromMap({
      "first_name":firstName,
      "last_name":lastName,
      "email":email,
      "password":password,
      "confirm_password":confirmPassword,
      "gender":gender,
      "phone_no":phoneNo,
    });
    try{
      Response response=await _dio.post(_baseurl+append,data: formData);
      var parsed=json.decode(response.data);


      print(parsed);
      return RegisterResponse.fromJson(parsed);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      throw error;
      //
      print(e.response.data);

    }
  }

  Future<ProductListResponse> getProductList(int productCategoryId) async{
    String append="products/getList";
    print(_baseurl+append);
    try{
      Response response=await _dio.get(_baseurl+append,queryParameters: {"product_category_id":productCategoryId});
      var parse=json.decode(response.data);

      // print(response.data);
       //print(parse);
      return ProductListResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      throw error;
      print(e.response.data);

    }
  }

  Future<ProductDetailsResponse> getProductDetail(int productId) async{
    String append="products/getDetail";
    print(_baseurl+append);
    try{
      Response response=await _dio.get(_baseurl+append,queryParameters: {"product_id":productId});
      var parse=json.decode(response.data);

      // print(response.data);
      //print(parse);
      return ProductDetailsResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      throw error;
      print(e.response.data);

    }
  }

  Future<ProductRatingResponse> setRating(int productId,int rating) async{
    String append="products/setRating";
    print(_baseurl+append);
    FormData formData=new FormData.fromMap({
      "product_id":productId,
      "rating":rating,
    });
    try{
      Response response=await _dio.post(_baseurl+append,data: formData);
      var parse=json.decode(response.data);

      // print(response.data);
      //print(parse);
      return ProductRatingResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      print(e.response.data);
      throw error;

    }
  }

  Future<CartResponse> addtoCart(String token, productId,int quantity) async{
    String append="addToCart";
    print(_baseurl+append);
    FormData formData=new FormData.fromMap({
      "product_id":productId,
      "quantity":quantity,
    });
    try{
      Response response=await _dio.post(_baseurl+append,data: formData,options: Options(
        headers: {"access_token":token},));
      var parse=json.decode(response.data);

      // print(response.data);
      //print(parse);
      return CartResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      //print(e.response.data);
      throw error;

    }
  }

  Future<CartResponse> editCart( int productId,int quantity) async{
    String append="editCart";
    print(_baseurl+append);
    String token=await getAccessToken()  ?? "no token";
    FormData formData=new FormData.fromMap({
      "product_id":productId,
      "quantity":quantity,
    });
    try{
      Response response=await _dio.post(_baseurl+append,data: formData,options: Options(
        headers: {"access_token":token},));
      var parse=json.decode(response.data);

      // print(response.data);
      //print(parse);
      return CartResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      //print(e.response.data);
      throw error;

    }
  }

  Future<CartResponse> deleteCart(int productId) async{
    String append="deleteCart";
    print(_baseurl+append);
    String token=await getAccessToken()  ?? "no token";
    FormData formData=new FormData.fromMap({
      "product_id":productId,
    });
    try{
      Response response=await _dio.post(_baseurl+append,data: formData,options: Options(
        headers: {"access_token":token},));
      var parse=json.decode(response.data);

      // print(response.data);
      //print(parse);
      return CartResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      //print(e.response.data);
      throw error;

    }
  }


  Future<ListCartResponse> listCart() async{
    String append="cart";
    print(_baseurl+append);
    String token=await getAccessToken()  ?? "no token";
    print(token);
    try{
      Response response=await _dio.get(_baseurl+append,options: Options(
        headers: {"access_token":token},));
      var parse=json.decode(response.data);

       //print(response.data);
      //print(parse);
      return ListCartResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      //print(e.response.data);

      throw error;


    }
  }
  getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token');

    return token;
  }

  Future<OrderResponse> order(String address) async{
    String append="order";
    print(_baseurl+append);
    FormData formData=new FormData.fromMap({
      "address":address,


    });
    String token=await getAccessToken()  ?? "no token";

    try{
      Response response=await _dio.post(_baseurl+append,data: formData,options: Options(
        headers: {"access_token":token},));
      var parse=json.decode(response.data);

      // print(response.data);
      //print(parse);
      return OrderResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      //print(e.response.data);
      throw error;

    }
  }

  Future<OrderListResponse> listOrder() async{
    String append="orderList";
    print(_baseurl+append);
    String token=await getAccessToken()  ?? "no token";
    print(token);
    try{
      Response response=await _dio.get(_baseurl+append,options: Options(
        headers: {"access_token":token},));
      var parse=json.decode(response.data);

      //print(response.data);
      print(parse);
      return OrderListResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      //print(e.response.data);

      throw error;


    }
  }

  Future<OrderDetailsResponse> orderDetail(int id) async{
    String append="orderDetail";
    print(_baseurl+append);
    String token=await getAccessToken()  ?? "no token";
    print(token);
    try{
      Response response=await _dio.get(_baseurl+append,
        queryParameters: {"order_id":id},
          options: Options(
        headers: {"access_token":token},));
      var parse=json.decode(response.data);

      //print(response.data);
      print(parse);
      return OrderDetailsResponse.fromJson(parse);
    }on DioError catch(e){
      var error=json.decode(e.response.data);
      //print(e.response.data);

      throw error;


    }
  }




}

