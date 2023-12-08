import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/presentation/presenters/presenters.dart';
import 'package:survey_for_dev/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  late StreamLoginPresenter sut;
  late Validation validation;
  late String email;

  When mockeValidationCall(String? field) => when(() => validation.validate(field: field ?? any(named: 'field'), value: any(named: 'value')));

  void mockValidation({ String? field, String? value }) {
    mockeValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);
    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'any_error');
    expectLater(sut.emailErrorStream, emits('any_error'));
    sut.validateEmail(email);
  });
}
