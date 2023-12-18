import 'package:equatable/equatable.dart';
import 'package:survey_for_dev/validation/protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;
  @override
  List<Object?> get props => [field];
  const RequiredFieldValidation(this.field);

  @override
  String? validate(String value) {
    return value.isEmpty ? 'Campo obrigatório' : null;
  }
}
