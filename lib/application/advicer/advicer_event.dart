part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerEvent {}


///Event when Button is pressed 
class AdviceRequestedEvent extends AdvicerEvent {}
