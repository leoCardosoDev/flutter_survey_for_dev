import 'package:test/test.dart';
import 'package:survey_for_dev/validation/validators/validators.dart';

void main() {
 test('Should return null if email is empty', () {
  final sut = EmailValidation('any_field');
  expect(sut.validate(''), null);
 });
}
