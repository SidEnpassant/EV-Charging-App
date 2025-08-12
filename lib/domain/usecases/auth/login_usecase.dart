import 'package:chargerrr/domain/entities/user.dart';
import 'package:chargerrr/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<User> call(String email, String password) {
    return _authRepository.login(email, password);
  }
}