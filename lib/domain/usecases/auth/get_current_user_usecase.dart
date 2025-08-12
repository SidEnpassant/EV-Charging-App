import 'package:chargerrr/domain/entities/user.dart';
import 'package:chargerrr/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);

  Future<User?> call() {
    return _authRepository.getCurrentUser();
  }
}