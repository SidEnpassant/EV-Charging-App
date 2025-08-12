import 'package:chargerrr/domain/entities/user.dart';
import 'package:chargerrr/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<User> call(String email, String password, String name) {
    return _authRepository.register(email, password, name);
  }
}