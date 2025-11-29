import 'api_service.dart';
import 'api_constants.dart';

class DiagnosisService {
  static Future<Map<String, dynamic>> saveDiagnosis({
    required String imageUrl,
    required String diseaseName,
    String? diseaseSeverity,
    double? confidence,
    String? description,
    Map<String, dynamic>? treatments,
  }) async {
    final body = {
      'imageUrl': imageUrl,
      'diseaseName': diseaseName,
      if (diseaseSeverity != null) 'diseaseSeverity': diseaseSeverity,
      if (confidence != null) 'confidence': confidence,
      if (description != null) 'description': description,
      if (treatments != null) 'treatments': treatments,
    };

    return await ApiService.post(
      ApiConstants.diagnosesCreate,
      body,
      requiresAuth: true,
    );
  }

  static Future<Map<String, dynamic>> getUserDiagnoses({
    int limit = 20,
    int offset = 0,
  }) async {
    return await ApiService.get(
      ApiConstants.diagnosesList,
      requiresAuth: true,
      queryParams: {
        'limit': limit.toString(),
        'offset': offset.toString(),
      },
    );
  }

  static Future<Map<String, dynamic>> getDiagnosisById(String id) async {
    return await ApiService.get(
      '${ApiConstants.diagnoses}/$id',
      requiresAuth: true,
    );
  }

  static Future<Map<String, dynamic>> toggleBookmark(String id) async {
    return await ApiService.patch(
      '${ApiConstants.diagnoses}/$id/bookmark',
      requiresAuth: true,
    );
  }

  static Future<Map<String, dynamic>> getBookmarkedDiagnoses() async {
    return await ApiService.get(
      ApiConstants.diagnosesBookmarked,
      requiresAuth: true,
    );
  }

  static Future<Map<String, dynamic>> deleteDiagnosis(String id) async {
    return await ApiService.delete(
      '${ApiConstants.diagnoses}/$id',
      requiresAuth: true,
    );
  }
}
