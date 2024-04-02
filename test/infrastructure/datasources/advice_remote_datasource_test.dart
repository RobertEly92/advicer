import 'package:advicer/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'advice_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AdvicerRemoteDatasource advicerRemoteDatasource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    advicerRemoteDatasource = AdvicerRemoteDatasourceImpl(client: mockClient);
  });

  //arrange functions
  void setUpMockClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('advice_response.json'), 200));
  }

  void setUpMockClientFailure() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('something went wrong', 404));
  }

  group('getRandomAdviceFromApi', () {
    final tAdvicemodel = AdviceModel(advice: 'test', id: 1);
    test(
        'should perform get request on a URL with advice being the endpoint and header application/json',
        () {
      //arrange
      setUpMockClientSuccess200();
      //act
      advicerRemoteDatasource.getRandomAdviceFromApi();
      //assert
      verify(mockClient
          .get(Uri.parse('https://api.adviceslip.com/advice'), headers: {
        'Content-Type': 'application/json',
      }));
    });
test(
        'should return a valid advice when the response is a success 200',
        () async {
      //arrange
      setUpMockClientSuccess200();
      //act
      final result = await advicerRemoteDatasource.getRandomAdviceFromApi();
      
      //assert
      expect(result, tAdvicemodel);
    });
  test(
        'should throw serverexception if statuscode is not 200',
        ()  {
      //arrange
      setUpMockClientFailure();
      //act
      final call = advicerRemoteDatasource.getRandomAdviceFromApi;
      
      //assert
      expect(()=> call(), throwsA(const TypeMatcher<ServerException>()));
    });
    
  });
}
