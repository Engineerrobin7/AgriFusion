import 'api_service.dart';
import 'api_constants.dart';

class UserService {
  static Future<Map<String, dynamic>> register({
    required String fullName,
    String? email,
    String? phone,
    String? password,
    double? farmSize,
    String? farmLocation,
    List<String>? cropTypes,
    String? languagePreference,
  }) async {
    final body = {
      'fullName': fullName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (password != null) 'password': password,
      if (farmSize != null) 'farmSize': farmSize,
      if (farmLocation != null) 'farmLocation': farmLocation,
      if (cropTypes != null) 'cropTypes': cropTypes,
      if (languagePreference != null) 'languagePreference': languagePreference,
    };

    final response = await ApiService.post(
      ApiConstants.userRegister,
      body,
    );

    if (response['success'] == true && response['token'] != null) {
      await ApiService.saveToken(response['token']);
    }

    return response;
  }

  static Future<Map<String, dynamic>> login({
    String? email,
    String? phone,
    required String password,
  }) async {
    final body = {
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'password': password,
    };

    final response = await ApiService.post(
      ApiConstants.userLogin,
      body,
    );

    if (response['success'] == true && response['token'] != null) {
      await ApiService.saveToken(response['token']);
    }

    return response;
  }

  static Future<Map<String, dynamic>> getProfile() async {
    return await ApiService.get(
      ApiConstants.userProfile,
      requiresAuth: true,
    );
  }

  static Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> updates,
  ) async {
    return await ApiService.put(
      ApiConstants.userProfile,
      updates,
      requiresAuth: true,
    );
  }

  static Future<void> logout() async {
    await ApiService.clearToken();
  }

  static Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null;
  }
}
