import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/models/app_user.dart';
import '../data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => MockAuthRepository(const FlutterSecureStorage()),
);

final authSessionProvider = AsyncNotifierProvider<AuthSessionNotifier, AppUser?>(
  AuthSessionNotifier.new,
);

class AuthSessionNotifier extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.getCurrentUser();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(() => authRepository.login(email, password));
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(
      () => authRepository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      ),
    );
  }

  Future<void> logout() async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.logout();
    state = const AsyncData(null);
  }
}
