import 'package:http/http.dart';

import '../../../application/http/http.dart';
import '../../../infra/http/http.dart';

HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}
