import '../../../domain/usecases/usecases.dart';
import '../../../application/usecases/usecases.dart';
import '../factories.dart';

Authentication makeRemoteAuthentication() =>
  RemoteAuthentication(httpClient: makeHttpAdapter(), url: makeApiUrl('login'));

