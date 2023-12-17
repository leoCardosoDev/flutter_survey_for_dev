import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/validation/protocols/protocols.dart';
import 'package:survey_for_dev/validation/validators/validators.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  late ValidationComposite sut;
  late FieldValidation validation1;
  late FieldValidation validation2;
  late FieldValidation validation3;

  void mockValidation1(String? error) {
    when(() => validation1.validate(any())).thenReturn(error);
  }

  void mockValidation2(String? error) {
    when(() => validation2.validate(any())).thenReturn(error);
  }

  void mockValidation3(String? error) {
    when(() => validation3.validate(any())).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(() => validation1.field).thenReturn('any_field');
    mockValidation1(null);
    validation2 = FieldValidationSpy();
    when(() => validation2.field).thenReturn('any_field');
    mockValidation2(null);
    validation3 = FieldValidationSpy();
    when(() => validation3.field).thenReturn('other_field');
    mockValidation3(null);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

 test('should return null if all validations returns null or empty', () {
  mockValidation2('');
  final error = sut.validate(field: 'any_field', value: 'any_value');
  expect(error, null);
 });

 test('should return the first error found', () {
  mockValidation1('error_1');
  mockValidation2('error_2');
  mockValidation3('error_3');
  final error = sut.validate(field: 'any_field', value: 'any_value');
  expect(error, 'error_1');
 });
}
