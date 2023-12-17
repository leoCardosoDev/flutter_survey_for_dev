import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:survey_for_dev/validation/protocols/protocols.dart';
import 'package:survey_for_dev/validation/validators/validators.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
 test('should return null if all validations returns null or empty', () {
  final validation1 = FieldValidationSpy();
  when(() => validation1.field).thenReturn('any_field');
  when(() => validation1.validate(any())).thenReturn(null);
  final validation2 = FieldValidationSpy();
  when(() => validation2.field).thenReturn('any_field');
  when(() => validation2.validate(any())).thenReturn('');
  final sut = ValidationComposite([validation1, validation2]);
  final error = sut.validate(field: 'any_field', value: 'any_value');
  expect(error, null);
 });
}