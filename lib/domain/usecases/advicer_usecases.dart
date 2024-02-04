import 'dart:io';

import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdvicerUsecases{

  Future<Either<Failure, AdviceEntity>> getAdviceUsecase()async{
    //call repo for advice

    //Buisness logic implementieren, calculations etc. 
    sleep(Duration(seconds: 2));
    //return Left(ServerFailure());
    return Right(AdviceEntity( advice: 'bsp', id: 1));
    

  }
}