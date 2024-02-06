part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerState {}

final class AdvicerInitial extends AdvicerState with EquatableMixin{
  @override
  List<Object?> get props => [];
}

final class AdvicerStateLoading extends AdvicerState with EquatableMixin{
  @override
  List<Object?> get props => [];
}

final class AdvicerStateLoaded extends AdvicerState with EquatableMixin{
  @override
  List<Object?> get props => [advice];

  final String advice;
  AdvicerStateLoaded({required this.advice});

}

final class AdvicerStateError extends AdvicerState with EquatableMixin{
  @override
  List<Object?> get props => [message];

  final String message;
  AdvicerStateError({required this.message});
}
