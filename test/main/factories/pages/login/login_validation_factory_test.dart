import 'package:survey_for_dev/main/factories/factories.dart';
import 'package:survey_for_dev/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {

 test('Should returns the correct validations', () {
  final validations = makeLoginValidations();
  expect(validations, [
    const RequiredFieldValidation('email'),
    const EmailValidation('email'),
    const RequiredFieldValidation('password')
  ]);
 });
}
