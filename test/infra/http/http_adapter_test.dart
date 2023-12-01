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
    await client.post(Uri.parse(url));
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group("POST", () {
    test("Should call post with correct values", () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();
      when(() => client.post(Uri.parse(url))).thenAnswer((_) => Future.value(Response('', 200)));
      await sut.request(url: url, method: 'post');
      verify(() => client.post(Uri.parse(url))).called(1);
    });
  });
}
