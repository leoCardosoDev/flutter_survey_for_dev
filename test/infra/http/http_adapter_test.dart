import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/application/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map<String, dynamic>> request({
    required String url,
    required String method,
    Map<String, dynamic>? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(Uri.parse(url), headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      return response.body.isEmpty ? {} : jsonDecode(response.body);
    } else {
      return {};
    }
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
    When mockRequest() => when(() => client.post(Uri.parse(url), headers: any(named: 'headers'), body: any(named: 'body')));

    void mockResponse(int statusCode, { String body = '{"any_key":"any_value"}' }) {
      mockRequest().thenAnswer((_) => Future.value(Response(body, statusCode)));
    }

    setUp((){
     mockResponse(200);
    });
    
    test("Should call post with correct values", () async {
      await sut.request(url: url, method: 'post', body: body);
      verify(() => client.post(Uri.parse(url), headers: headers, body: '{"any_key":"any_value"}')).called(1);
    });

    test("Should call post without body", () async {
      await sut.request(url: url, method: 'post');
      verify(() => client.post(Uri.parse(url), headers: headers));
    });

    test("Should return data if post returns 200", () async {
      final response = await sut.request(url: url, method: 'post', body: body);
      expect(response, {'any_key': 'any_value'});
    });

    test("Should return null if post returns 200 with no data", () async {
      mockResponse(200, body: '');
      final response = await sut.request(url: url, method: 'post', body: body);
      expect(response, {});
    });

    test("Should return null if post returns 204 without data", () async {
      mockResponse(204, body: '');
      final response = await sut.request(url: url, method: 'post', body: body);
      expect(response, {});
    });

    test("Should return null if post returns 204 with data", () async {
      mockResponse(204);
      final response = await sut.request(url: url, method: 'post', body: body);
      expect(response, {});
    });
  });
}
