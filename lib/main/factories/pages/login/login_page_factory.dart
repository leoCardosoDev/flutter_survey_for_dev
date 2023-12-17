import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:survey_for_dev/application/usecases/remote_authentication.dart';
import 'package:survey_for_dev/infra/http/http.dart';
import 'package:survey_for_dev/presentation/presenters/presenters.dart';
import 'package:survey_for_dev/validation/validators/email_field_validaton.dart';
import 'package:survey_for_dev/validation/validators/required_field_validation.dart';
import 'package:survey_for_dev/validation/validators/validation_composite.dart';
import '../../../../ui/pages/login/login_page.dart';

Widget makeLoginPage() {
  final validationComposite = ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password')
  ]);
  final client = Client();
  final httpAdapter = HttpAdapter(client);
  const url = 'https://apicleanarchitecturesurvey-production.up.railway.app/api/login';
  final remoteAuthentication = RemoteAuthentication(httpClient: httpAdapter, url: url);
  final presenter = StreamLoginPresenter(
    authentication: remoteAuthentication,
    validation: validationComposite
  );
  return LoginPage(presenter);
}
