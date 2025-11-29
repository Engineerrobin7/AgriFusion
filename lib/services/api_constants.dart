class ApiConstants {
  static const String baseUrl = 'http://localhost:3000/api';
  
  static const String users = '$baseUrl/users';
  static const String diagnoses = '$baseUrl/diagnoses';
  static const String voice = '$baseUrl/voice';
  static const String weather = '$baseUrl/weather';
  
  static String userRegister = '$users/register';
  static String userLogin = '$users/login';
  static String userProfile = '$users/profile';
  
  static String diagnosesCreate = diagnoses;
  static String diagnosesList = diagnoses;
  static String diagnosesBookmarked = '$diagnoses/bookmarked';
  
  static String voiceQuery = '$voice/query';
  static String voiceQueryBookmarked = '$voice/query/bookmarked';
  static String chat = '$voice/chat';
  
  static String weatherData = weather;
  static String weatherLocations = '$weather/locations';
}
