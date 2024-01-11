import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/infra/cache/cache.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  late LocalStorageAdapter sut;
  late FlutterSecureStorageSpy secureStorage;
  late String key;
  late String value;

  When mockSecureStorage () => when(() => secureStorage.write(key: any(named: 'key'), value: any(named: 'value')));

  void mockSuccess() {
    mockSecureStorage().thenAnswer((_) async => Future.value());
  }

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
    mockSuccess();
  });

 test('Should call save secure with correct values', () async {
  await sut.saveSecure(key: key, value: value);
  verify(() => secureStorage.write(key: key, value: value));
 });
}
