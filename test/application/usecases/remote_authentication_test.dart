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

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
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
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
    .thenThrow(HttpError.badRequest);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
    .thenThrow(HttpError.notFound);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
    .thenThrow(HttpError.serverError);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
}
