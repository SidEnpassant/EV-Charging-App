import 'package:chargerrr/data/datasources/remote/supabase_auth_datasource.dart';
import 'package:chargerrr/domain/entities/user.dart';
import 'package:chargerrr/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<User> login(String email, String password) {
    return _authDataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String name) {
    return _authDataSource.register(email, password, name);
  }

  @override
  Future<void> logout() {
    return _authDataSource.logout();
  }

  @override
  Future<User?> getCurrentUser() {
    return _authDataSource.getCurrentUser();
  }
}