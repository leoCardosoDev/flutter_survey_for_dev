import 'package:survey_for_dev/validation/protocols/protocols.dart';

class RequiredFieldValidation implements FieldValidation {
  @override
  final String field;
  RequiredFieldValidation(this.field);

  @override
  String? validate(String value) {
    return null;
  }
}
