import 'package:clinica/clinica.dart';
import 'package:fe_lab_clinica_self_service/src/services/user_login_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginController with MessageStateMixin {
  LoginController({required UserLoginService loginService})
      : _loginService = loginService;

  final UserLoginService _loginService;

  final _obscurePassword = signal(true);
  final _logged = signal(false);

  bool get logged => _logged();
  bool get obscurePassword => _obscurePassword();

  void passwordTogger() => _obscurePassword.value = !_obscurePassword();

  Future<void> login(String username, String password) async {
    final loginResult = await _loginService.execute(username, password);
    switch (loginResult) {
      case Left(value: ServiceException(:final message)):
        showError(message);
      case Right(value: _):
        _logged.value = true;
      // showSuccess("Login realizado com sucesso");
    }
  }
}
