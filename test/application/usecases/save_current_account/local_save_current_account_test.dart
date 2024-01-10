import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:survey_for_dev/application/cache/cache.dart';
import 'package:survey_for_dev/domain/entities/entities.dart';
import 'package:survey_for_dev/domain/helpers/helpers.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/application/usecases/usecases.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {
 test('should call SaveSecureCacheStorage with correct values', () async {
  final saveSecureCacheStorage = SaveSecureCacheStorageSpy();
  final sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
  final account = AccountEntity(faker.guid.guid());
  when(() => saveSecureCacheStorage.saveSecure(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async => Future.value());
  await sut.save(account);
  verify(() => saveSecureCacheStorage.saveSecure(key: 'token', value: account.token)).called(1);
 });

  test('should throw UnexpectedError if SaveSecureCacheStorage throws', () async {
  final saveSecureCacheStorage = SaveSecureCacheStorageSpy();
  final sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
  final account = AccountEntity(faker.guid.guid());
  when(() => saveSecureCacheStorage.saveSecure(key: any(named: 'key'), value: any(named: 'value'))).thenThrow(Exception());
  final future = sut.save(account);
  expect(future, throwsA(DomainError.unexpected));
 });
}
