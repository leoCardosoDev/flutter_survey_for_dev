import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/infra/cache/cache.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
 test('Should call save secure with correct values', () async {
  final secureStorage = FlutterSecureStorageSpy();
  final sut = LocalStorageAdapter(secureStorage: secureStorage);
  final key = faker.lorem.word();
  final value = faker.guid.guid();
  when(() => secureStorage.write(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async => Future.value());
  await sut.saveSecure(key: key, value: value);
  verify(() => secureStorage.write(key: key, value: value));
 });
}
