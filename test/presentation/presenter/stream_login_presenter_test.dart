import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/domain/entities/entities.dart';
import 'package:survey_for_dev/domain/helpers/helpers.dart';
import 'package:survey_for_dev/domain/usecases/usecases.dart';

import 'package:survey_for_dev/presentation/presenters/presenters.dart';
import 'package:survey_for_dev/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}
class AuthenticationSpy extends Mock implements Authentication {}

void main() {
  late StreamLoginPresenter sut;
  late Validation validation;
  late Authentication authentication;
  late String email;
  late String password;

  When mockValidationCall(String? field) => when(() => validation.validate(field: field ?? any(named: 'field'), value: any(named: 'value')));

  void mockValidation({ String? field, String? value }) {
    mockValidationCall(field).thenReturn(value);
  }

  When mockAuthenticationCall() => when(() => authentication.auth(captureAny()));

  void mockAuthentication() {
    mockAuthenticationCall().thenAnswer((_) async =>  AccountEntity(faker.guid.guid()));
  }

  void mockAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  setUpAll(() {
    registerFallbackValue(AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password()));
  });

  setUp(() {
    authentication = AuthenticationSpy();
    authentication = AuthenticationSpy();
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
    mockAuthentication();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);
    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'any_error');
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'any_error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct password', () {
    sut.validatePassword(password);
    verify(() => validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit password error if validation fails', () {
    mockValidation(value: 'any_error');
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, 'any_error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password null if validation succeeds', () {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit error if any field error', () {
    mockValidation(field: 'email', value: 'any_error');
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'any_error')));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit isFormValid true if all fields succeeds', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call Authentication with correct params', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();
    verify(() => authentication.auth(AuthenticationParams(email: email, secret: password))).called(1);
  });

  test('Should emits correct event on Authentication succeeds', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);
     expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    await sut.auth();
  });

  test('Should emits correct events on InvalidCredentialsError', () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);
    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, 'Credenciais inválidas')));
    await sut.auth();
  });

  test('Should emits correct events on UnexpectedError', () async {
    mockAuthenticationError(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validatePassword(password);
    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, 'Algo errado aconteceu. Tente novamente em breve')));
    await sut.auth();
  });
}
