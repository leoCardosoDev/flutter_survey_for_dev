import 'package:test/test.dart';

import 'package:survey_for_dev/validation/validators/validators.dart';

void main() {
 test('Should return null if value is not empty', () {
  final sut = RequiredFieldValidation('any_field');
  final error = sut.validate('any_value');
  expect(error, null);
 });
}
