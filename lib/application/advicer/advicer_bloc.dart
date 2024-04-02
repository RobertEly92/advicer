import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


part 'advicer_event.dart';
part 'advicer_state.dart';

const GENERAL_FAILURE_MESSAGE = 'Ups, something gone wrong please try again';
const SERVER_FAILURE_MESSAGE = 'Ups, API Error, please try again';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdvicerUsecases  usecases; 
  AdvicerBloc({required this.usecases}) : super(AdvicerInitial()) {
    
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
        return SERVER_FAILURE_MESSAGE;

      case GeneralFailure:
        return GENERAL_FAILURE_MESSAGE;
      default:
        return GENERAL_FAILURE_MESSAGE;
    }
  }
}
