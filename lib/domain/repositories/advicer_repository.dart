import 'package:advicer/domain/entities/advice_entity.dart';

abstract class AdvicerRepository {
  Future<AdviceEntity> getAdviceFromAPI();
}