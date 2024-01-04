import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

LoginPresenter makeStreamLoginPresenter()  => StreamLoginPresenter(
  authentication: makeRemoteAuthentication(),
  validation: makeLoginValidation()
);

LoginPresenter makeGetxLoginPresenter()  => GetxLoginPresenter(
  authentication: makeRemoteAuthentication(),
  validation: makeLoginValidation()
);
