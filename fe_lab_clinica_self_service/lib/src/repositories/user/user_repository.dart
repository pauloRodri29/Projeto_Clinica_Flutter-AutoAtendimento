import 'package:clinica/clinica.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
