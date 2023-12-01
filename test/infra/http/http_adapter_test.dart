import 'dart:convert';

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
    final jsonBody = body != null ? jsonEncode(body) : null;
    await client.post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late String url;
  late Map<String, String>? headers;
  late Map<String, String>? body;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    body = {'any_key': 'any_value'};
  });

  group("POST", () {
    test("Should call post with correct values", () async {
      when(() => client.post(Uri.parse(url), headers: headers, body: jsonEncode(body))).thenAnswer((_) => Future.value(Response('', 200)));
      await sut.request(url: url, method: 'post', body: body);
      verify(() => client.post(Uri.parse(url), headers: headers, body: '{"any_key":"any_value"}')).called(1);
    });

    test("Should call post without body", () async {
      when(() => client.post(Uri.parse(url), headers: headers)).thenAnswer((_) => Future.value(Response('', 200)));
      await sut.request(url: url, method: 'post');
      verify(() => client.post(Uri.parse(url), headers: headers));
    });
  });
}
