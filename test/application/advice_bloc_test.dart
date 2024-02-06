import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';
import 'advice_bloc_test.mocks.dart';

@GenerateMocks([AdvicerUsecases])
void main(){

late AdvicerBloc advicerBloc;
late MockAdvicerUsecases mockAdvicerUsecases;

setUp(() {
  mockAdvicerUsecases = MockAdvicerUsecases();
  advicerBloc = AdvicerBloc(usecases: mockAdvicerUsecases);

});

test('init state should be AdvicerInitial', () {
  //arrange
  //act
  //assert
  expect(advicerBloc.state, equals(AdvicerInitial()));
});

group('AdviceRequestedEvent', () { 
  final t_advice = AdviceEntity(advice: 'test', id: 1);
  final t_advice_String = 'test';
  test('should call usecase if event is added', () async {
    //arrange
    when(mockAdvicerUsecases.getAdviceUsecase()).thenAnswer((_)async=>Right(t_advice));
    //act
    advicerBloc.add(AdviceRequestedEvent());
    await untilCalled(mockAdvicerUsecases.getAdviceUsecase());
    //assert
    verify(mockAdvicerUsecases.getAdviceUsecase());
    verifyNoMoreInteractions(mockAdvicerUsecases);
  });

  test('should emit loading then the loaded state after event is added', () async {
    //arrange
    when(mockAdvicerUsecases.getAdviceUsecase()).thenAnswer((_)async=>Right(t_advice));
    //assert later
    final expected = [
      AdvicerStateLoading(),
      AdvicerStateLoaded(advice: t_advice_String)
    ];
    expectLater(advicerBloc.stream, emitsInOrder(expected));
    //act
    advicerBloc.add(AdviceRequestedEvent());
    
  });

  test('should emit loading then the error state after event is added with server failure', () async {
    //arrange
    when(mockAdvicerUsecases.getAdviceUsecase()).thenAnswer((_)async=> Left(ServerFailure()));
    //assert later
    final expected = [
      AdvicerStateLoading(),
      AdvicerStateError(message: SERVER_FAILURE_MESSAGE),
    ];
    expectLater(advicerBloc.stream, emitsInOrder(expected));

    //act
    advicerBloc.add(AdviceRequestedEvent());
    
  });
  test('should emit loading then the error state after event is added with general failure', () async {
    //arrange
    when(mockAdvicerUsecases.getAdviceUsecase()).thenAnswer((_)async=> Left(GeneralFailure()));
    //assert later
    final expected = [
      AdvicerStateLoading(),
      AdvicerStateError(message: GENERAL_FAILURE_MESSAGE),
    ];
    expectLater(advicerBloc.stream, emitsInOrder(expected));
    
    //act
    advicerBloc.add(AdviceRequestedEvent());
    
  });
});
}