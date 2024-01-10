import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/domain/entities/entities.dart';
import 'package:survey_for_dev/domain/helpers/helpers.dart';

import 'package:survey_for_dev/application/cache/cache.dart';
import 'package:survey_for_dev/application/usecases/usecases.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {
  late SaveSecureCacheStorageSpy saveSecureCacheStorage;
  late LocalSaveCurrentAccount sut;
  late AccountEntity account;

  When mockWhen () => when(() => saveSecureCacheStorage.saveSecure(key: any(named: 'key'), value: any(named: 'value')));

  void mockSuccess () {
    mockWhen().thenAnswer((_) async => Future.value());
  }

  void mockException() {
    mockWhen().thenThrow(Exception());
  }

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(faker.guid.guid());
    mockSuccess();
  });

 test('should call SaveSecureCacheStorage with correct values', () async {
  await sut.save(account);
  verify(() => saveSecureCacheStorage.saveSecure(key: 'token', value: account.token)).called(1);
 });

  test('should throw UnexpectedError if SaveSecureCacheStorage throws', () async {
  mockException();
  final future = sut.save(account);
  expect(future, throwsA(DomainError.unexpected));
 });
}
