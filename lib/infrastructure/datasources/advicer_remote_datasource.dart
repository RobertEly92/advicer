import 'dart:convert';
import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdvicerRemoteDatasource {
  /// requests a random advice from api and throws serverexceptions if respond code is not 200
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdvicerRemoteDatasourceImpl implements AdvicerRemoteDatasource {
  final http.Client client;
  
  AdvicerRemoteDatasourceImpl({required this.client});

  @override
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    final response = await client
        .get(Uri.parse('https://api.adviceslip.com/advice'), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode != 200) {
      throw (ServerException());
    } else {
      final responseBody = jsonDecode(response.body);
      return AdviceModel.fromJson(responseBody['slip']);
    }
  }
}
