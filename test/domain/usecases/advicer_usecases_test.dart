import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/advicer_repository.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_usecases_test.mocks.dart';

@GenerateMocks([AdvicerRepository])
void main() {
  late AdvicerUsecases advicerUsecases;
  late MockAdvicerRepository mockAdvicerRepository;

  setUp(() {
    mockAdvicerRepository = MockAdvicerRepository();
    advicerUsecases = AdvicerUsecases(advicerRepository: mockAdvicerRepository);
  });

  group('getAdviceUsecase', () {
    final t_Advice = AdviceEntity(advice: 'Test', id: 1);
    test('should return the same advice as repository', () async {
      //arrange
      when(mockAdvicerRepository.getAdviceFromAPI())
          .thenAnswer((_) async => Right(t_Advice));
      //act
      final result = await advicerUsecases.getAdviceUsecase();
      //assert
      expect(result, Right(t_Advice));
      verify(mockAdvicerRepository.getAdviceFromAPI());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });
    test('should return the same ServerFailure as repository', () async {
      //arrange
      when(mockAdvicerRepository.getAdviceFromAPI())
          .thenAnswer((_) async => Left(ServerFailure()));
      //act
      final result = await advicerUsecases.getAdviceUsecase();
      //assert
      expect(result, Left(ServerFailure()));
      verify(mockAdvicerRepository.getAdviceFromAPI());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });
    test('should return the same GeneralFailure as repository', () async {
      //arrange
      when(mockAdvicerRepository.getAdviceFromAPI())
          .thenAnswer((_) async => Left(GeneralFailure()));
      //act
      final result = await advicerUsecases.getAdviceUsecase();
      //assert
      expect(result, Left(GeneralFailure()));
      verify(mockAdvicerRepository.getAdviceFromAPI());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });
  });
}
