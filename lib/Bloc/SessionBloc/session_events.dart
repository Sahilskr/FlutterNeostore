import 'package:equatable/equatable.dart';

abstract class SessionEvent extends Equatable{
}
class AppStarted extends SessionEvent{
  @override
  List<Object> get props => [];
}