
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SessionStates extends Equatable{

}
class SessionInitial extends SessionStates{
  @override
  List<Object> get props => [];
}
class AuthSuccessful extends SessionStates{
  final String name;
  final String email;
  AuthSuccessful({@required this.name,this.email} );



  @override
  List<Object> get props => [];
}
class UnAuthState extends SessionStates{
  @override
  List<Object> get props => [];

}