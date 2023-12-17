import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

LoginPresenter makeLoginPresenter()  => StreamLoginPresenter(
  authentication: makeRemoteAuthentication(),
  validation: makeLoginValidation()
);
