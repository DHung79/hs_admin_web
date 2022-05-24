import 'dart:convert' as convert;
import '../../authentication/resources/authentication_provider.dart';

class AuthenticationRepository {
  final provider = AuthenticationProvider();

  Future<dynamic> signUpWithEmailAndPassword(
      String? email, String? password) async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate a network delay
    final response = await provider
        .signUpWithEmailAndPassword({'email': email, 'password': password});
    return response;
  }

  Future<dynamic> signOut(Map<String, dynamic> params) async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate a network delay
    final body = convert.jsonEncode(params);
    final response = await provider.signOut(body);
    return response;
  }

  Future<dynamic> resetPassword(
      String email, String password, String token) async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate a network delay
    final body = convert.jsonEncode({
      'email': email,
      'password': password,
      'token': token,
    });
    final response = await provider.resetPassword(body);
    return response;
  }

  Future<dynamic> forgotPassword(String email) async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate a network delay
    final body = convert.jsonEncode({'email': email});
    final response = await provider.forgotPassword(body);
    return response;
  }

  Future<dynamic> removeFcmToken(String fcmToken) async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate a network delay
    final body = convert.jsonEncode({
      'fcm_token': fcmToken,
    });
    final response = await provider.removeFcmToken(body);
    return response;
  }

  Future<dynamic> loginWithFacebook(String? accessToken) async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate a network delay
    final response =
        await provider.signInWithFacebook({'accessToken': accessToken});
    return response;
  }

  Future<dynamic> loginWithGoogle(String? accessToken) async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate a network delay
    final response =
        await provider.signInWithGoogle({'accessToken': accessToken});
    return response;
  }

  Future<dynamic> adminLogin(String? email, String? password) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final response = await provider
        .adminLogin({'email': email, 'password': password});
    return response;
  }
}
