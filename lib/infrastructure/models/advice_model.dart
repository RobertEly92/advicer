import 'package:advicer/domain/entities/advice_entity.dart';

class AdviceModel extends AdviceEntity {
  AdviceModel({required super.advice, required super.id});

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(advice: json['advice'], id: json['id']);
  }
}
