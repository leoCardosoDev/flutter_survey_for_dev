import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/domain/helpers/helpers.dart';
import 'package:survey_for_dev/domain/usecases/authentication.dart';

import 'package:survey_for_dev/application/http/http.dart';
import 'package:survey_for_dev/application/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late AuthenticationParams params;
  late String url;

  Map<String, dynamic> mockValidData() => {"accessToken": faker.guid.guid(), "name": faker.person.name()};

  When mockeRequest() => 
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')));
  
  void mockHttpData(Map<String, dynamic> data) {
    mockeRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockeRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    mockHttpData(mockValidData());
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.auth(params);
    verify(() => httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401', () async {
    mockHttpError(HttpError.unauthorized);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return a Account if HttpClient returns 200', () async {
    final validData = mockValidData();
    mockHttpData(validData);
    final account = await sut.auth(params);
    expect(account.token, validData['accessToken']);
  });

  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    mockHttpData({ "invalid_key": 'invalid_value' });
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
}
