import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/advicer_repository.dart';
import 'package:advicer/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class AdvicerRepositoryImpl implements AdvicerRepository {
//TODO füge localDatasource hinzu - speichere Advice in local - get advice aus local und nutze das

  final AdvicerRemoteDatasource advicerRemoteDatasource;
  AdvicerRepositoryImpl({required this.advicerRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromAPI() async {
    try {
      final remoteAdvice =
          await advicerRemoteDatasource.getRandomAdviceFromApi();
      return Right(remoteAdvice);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}
