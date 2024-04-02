import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/advicer_repository.dart';
import 'package:advicer/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';
import 'package:advicer/infrastructure/repositories/advicer_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_repository_test.mocks.dart';

@GenerateMocks([AdvicerRemoteDatasource])
void main() {
  late AdvicerRepository advicerRepository;
  late MockAdvicerRemoteDatasource mockAdvicerRemoteDatasource;

  setUp(() {
    mockAdvicerRemoteDatasource = MockAdvicerRemoteDatasource();
    advicerRepository = AdvicerRepositoryImpl(
        advicerRemoteDatasource: mockAdvicerRemoteDatasource);
  });

  group('getAdviceFromApi testen', () { 
    final tAdvicemodel = AdviceModel(advice: 'test', id: 1);
    final AdviceEntity tAdvice = tAdvicemodel;
    
    test('should return remote data if call to remotedatasource is successful', () async{
      //arrange
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromApi()).thenAnswer((_)async=> tAdvicemodel);
      //act
    final result = await advicerRepository.getAdviceFromAPI();
      //assert
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Right(tAdvice));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });

       test('should return serverfailue if call to remotedatasource throws serverexception', () async{
      //arrange
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromApi()).thenThrow(ServerException());
      //act
    final result = await advicerRepository.getAdviceFromAPI();
      //assert
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });

      test('should return serverfailue if call to remotedatasource throws exception', () async{
      //arrange
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromApi()).thenThrow(Exception());
      //act
    final result = await advicerRepository.getAdviceFromAPI();
      //assert
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Left(GeneralFailure()));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });


  });
}
