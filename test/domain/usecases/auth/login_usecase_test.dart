import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:chargerrr/domain/entities/user.dart';
import 'package:chargerrr/domain/repositories/auth_repository.dart';
import 'package:chargerrr/domain/usecases/auth/login_usecase.dart';

@GenerateMocks([AuthRepository])
import 'login_usecase_test.mocks.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  final testUser = User(
    id: 'test-id',
    email: 'test@example.com',
    name: 'Test User',
    avatarUrl: null,
    createdAt: DateTime.now(),
  );

  test('should login user with email and password', () async {
    // Arrange
    const email = 'test@example.com';
    const password = 'password123';
    when(mockAuthRepository.login(email, password))
        .thenAnswer((_) async => testUser);

    // Act
    final result = await loginUseCase(email, password);

    // Assert
    expect(result, equals(testUser));
    verify(mockAuthRepository.login(email, password));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should throw exception when login fails', () async {
    // Arrange
    const email = 'test@example.com';
    const password = 'wrong_password';
    when(mockAuthRepository.login(email, password))
        .thenThrow(Exception('Invalid credentials'));

    // Act & Assert
    expect(
      () => loginUseCase(email, password),
      throwsA(isA<Exception>()),
    );
    verify(mockAuthRepository.login(email, password));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}