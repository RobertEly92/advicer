import 'dart:convert';

import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final t_adviceModel = AdviceModel(advice: 'test', id: 1);

  test('model should be subclass of AdviceEntity', () {
//assert
    expect(t_adviceModel, isA<AdviceEntity>());
  });

  group('fromJson factory', () { 
    test('should return valid model if json advice is correct', () {
      //arrange

  final Map<String,dynamic> jsonMap = jsonDecode(fixture('advice.json'));

      //act
      final result = AdviceModel.fromJson(jsonMap);
      //assert
      expect(result,t_adviceModel);
    });
  });
}
