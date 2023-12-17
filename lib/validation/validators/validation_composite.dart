import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;
  ValidationComposite(this.validations);

  @override
  String? validate({required String field, required String value}) {
    return null;
  }
}
