part of 'advicer_bloc.dart';

sealed class AdvicerEvent {}


///Event when Button is pressed 
class AdviceRequestedEvent extends AdvicerEvent {}
