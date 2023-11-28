import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/domain/usecases/authentication.dart';
import 'package:survey_for_dev/application/http/http.dart';
import 'package:survey_for_dev/application/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    await sut.auth(params);
    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {'email': params.email, 'password': params.secret}));
  });
}
