import '../protocols/protocols.dart';

class EmailValidation implements FieldValidation {
  @override
  final String field;
  EmailValidation(this.field);

  @override
  String? validate(String value) {
    return null;
  }
}
