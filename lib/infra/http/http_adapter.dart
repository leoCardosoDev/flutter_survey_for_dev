import 'dart:convert';

import 'package:http/http.dart';

import '../../application/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map<String, dynamic>> request(
    {required String url, required String method, Map<String, dynamic>? body}) async 
  {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    try {
      if (method == 'post') {
        response = await client.post(Uri.parse(url), headers: headers, body: jsonBody);
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? {} : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return {};
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if(response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else if(response.statusCode == 403) {
      throw HttpError.forbbiden;
    } else if(response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
