import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:survey_for_dev/application/cache/save_cache_storage.dart';
import 'package:survey_for_dev/domain/entities/entities.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/application/usecases/usecases.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {
 test('should call SaveCacheStorage with correct values', () async {
  final saveSecureCacheStorage = SaveSecureCacheStorageSpy();
  final sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
  final account = AccountEntity(faker.guid.guid());
  await sut.save(account);
  verify(() => saveSecureCacheStorage.saveSecure(key: 'token', value: account.token)).called(1);
 });
}
