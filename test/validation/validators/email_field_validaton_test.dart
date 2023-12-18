import 'package:test/test.dart';
import 'package:survey_for_dev/validation/validators/validators.dart';

void main() {
  late EmailValidation sut;

  setUp((){
    sut = const EmailValidation('any_field');
  });
 test('Should return null if email is empty', () {
  expect(sut.validate(''), null);
 });

 test('Should return null if email is valid', () {
  expect(sut.validate('any_email@mail.com'), null);
 });

 test('Should return error if email is invalid', () {
  expect(sut.validate('any_email@'), 'E-mail inválido');
 });
}
