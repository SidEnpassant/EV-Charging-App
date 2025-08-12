// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:chargerrr/data/models/user_model.dart';

// abstract class SupabaseAuthDataSource {
//   Future<UserModel> login(String email, String password);
//   Future<UserModel> register(String email, String password, String name);
//   Future<void> logout();
//   Future<UserModel?> getCurrentUser();
// }

// class SupabaseAuthDataSourceImpl implements SupabaseAuthDataSource {
//   final _supabase = Supabase.instance.client;

//   @override
//   Future<UserModel> login(String email, String password) async {
//     try {
//       final response = await _supabase.auth.signInWithPassword(
//         email: email,
//         password: password,
//       );

//       if (response.user == null) {
//         throw Exception('Login failed');
//       }

//       final userData = await _supabase
//           .from('users')
//           .select()
//           .eq('id', response.user!.id)
//           .single();

//       return UserModel.fromJson({
//         'id': response.user!.id,
//         'email': response.user!.email!,
//         'name': userData['name'],
//         'avatar_url': userData['avatar_url'],
//         // 'created_at': response.user!.createdAt!.toIso8601String(),
//         'created_at': DateTime.parse(
//           response.user!.createdAt,
//         ).toIso8601String(),
//       });
//     } catch (e) {
//       throw Exception('Login failed: ${e.toString()}');
//     }
//   }

//   @override
//   Future<UserModel> register(String email, String password, String name) async {
//     try {
//       final response = await _supabase.auth.signUp(
//         email: email,
//         password: password,
//         data: {'name': name},
//       );

//       if (response.user == null) {
//         throw Exception('Registration failed');
//       }

//       final userData = await _supabase
//           .from('users')
//           .select()
//           .eq('id', response.user!.id)
//           .single();

//       return UserModel(
//         id: response.user!.id,
//         email: email,
//         name: userData['name'] ?? name,
//         avatarUrl: userData['avatar_url'],
//         createdAt: DateTime.parse(userData['created_at']),
//       );
//     } catch (e) {
//       throw Exception('Registration failed: ${e.toString()}');
//     }
//   }

//   @override
//   Future<void> logout() async {
//     try {
//       await _supabase.auth.signOut();
//     } catch (e) {
//       throw Exception('Logout failed: ${e.toString()}');
//     }
//   }

//   @override
//   Future<UserModel?> getCurrentUser() async {
//     try {
//       final user = _supabase.auth.currentUser;

//       if (user == null) {
//         return null;
//       }

//       final userData = await _supabase
//           .from('users')
//           .select()
//           .eq('id', user.id)
//           .maybeSingle();

//       if (userData == null) {
//         return null;
//       }

//       return UserModel.fromJson({
//         'id': user.id,
//         'email': user.email!,
//         'name': userData['name'],
//         'avatar_url': userData['avatar_url'],
//         // 'created_at': user.createdAt!.toIso8601String(),
//         'created_at': DateTime.parse(user.createdAt).toIso8601String(),
//       });
//     } catch (e) {
//       return null;
//     }
//   }
// }

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chargerrr/data/models/user_model.dart';

abstract class SupabaseAuthDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class SupabaseAuthDataSourceImpl implements SupabaseAuthDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Login failed');
      }

      final userData = await _supabase
          .from('users')
          .select()
          .eq('id', response.user!.id)
          .maybeSingle(); // ✅ changed from .single()

      if (userData == null) {
        throw Exception('User profile not found in database.');
      }

      return UserModel.fromJson({
        'id': response.user!.id,
        'email': response.user!.email!,
        'name': userData['name'],
        'avatar_url': userData['avatar_url'],
        'created_at': DateTime.parse(
          response.user!.createdAt,
        ).toIso8601String(),
      });
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw Exception('Registration failed');
      }

      final userData = await _supabase
          .from('users')
          .select()
          .eq('id', response.user!.id)
          .maybeSingle(); // ✅ changed from .single()

      return UserModel(
        id: response.user!.id,
        email: email,
        name: userData?['name'] ?? name, // safe null check
        avatarUrl: userData?['avatar_url'],
        createdAt: userData != null
            ? DateTime.parse(userData['created_at'])
            : DateTime.now(),
      );
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;

      if (user == null) {
        return null;
      }

      final userData = await _supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle(); // ✅ already correct

      if (userData == null) {
        return null;
      }

      return UserModel.fromJson({
        'id': user.id,
        'email': user.email!,
        'name': userData['name'],
        'avatar_url': userData['avatar_url'],
        'created_at': DateTime.parse(user.createdAt).toIso8601String(),
      });
    } catch (e) {
      return null;
    }
  }
}
