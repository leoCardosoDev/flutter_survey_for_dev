import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request(
      {required String url,
      required String method,
      Map<String, dynamic>? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    await client.post(Uri.parse(url), headers: headers);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group("POST", () {
    test("Should call post with correct values", () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();
      final headers = {
        'content-type': 'application/json',
        'accept': 'application/json'
      };
      when(() => client.post(Uri.parse(url), headers: headers)).thenAnswer((_) => Future.value(Response('', 200)));
      await sut.request(url: url, method: 'post');
      verify(() => client.post(Uri.parse(url), headers: headers)).called(1);
    });
  });
}
