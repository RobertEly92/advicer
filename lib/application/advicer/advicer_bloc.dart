import 'dart:io';

import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {
    final usecases = AdvicerUsecases();

    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdvicerStateLoading());

      final Either<Failure, AdviceEntity> adviceOrFailure =
          await usecases.getAdviceUsecase();

      emit(adviceOrFailure.fold(
          (failure) =>
              AdvicerStateError(message: _mapFailureToMessage(failure)),
          (advice) => AdvicerStateLoaded(advice: advice.advice)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Ups, API Error, please try again';

      case GeneralFailure:
        return 'Ups, something gone wrong please try again';
      default:
        return 'Ups, please try again';
    }
  }
}
