import 'package:flutter/material.dart';
import '../presentation/chat_history/chat_history.dart';
import '../presentation/language_selection/language_selection.dart';
import '../presentation/voice_query/voice_query.dart';
import '../presentation/camera_diagnosis/camera_diagnosis.dart';
import '../presentation/weather_insights/weather_insights.dart';
import '../presentation/profile_settings/profile_settings.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/registration/registration.dart';
import '../presentation/home_dashboard/home_dashboard.dart';

class AppRoutes {
// Route constants
static const String initial = '/splash-screen';
static const String registration = '/registration';
static const String homeDashboard = '/home-dashboard';
static const String chatHistory = '/chat-history';
static const String languageSelection = '/language-selection';
static const String voiceQuery = '/voice-query';
static const String cameraDiagnosis = '/camera-diagnosis';
static const String weatherInsights = '/weather-insights';
static const String profileSettings = '/profile-settings';

// Map of routes
static Map<String, WidgetBuilder> routes = {
initial: (context) => const SplashScreen(),
registration: (context) => const Registration(),
homeDashboard: (context) => const HomeDashboard(),
chatHistory: (context) => const ChatHistory(),
languageSelection: (context) => const LanguageSelection(),
voiceQuery: (context) => const VoiceQuery(),
cameraDiagnosis: (context) => const CameraDiagnosis(),
weatherInsights: (context) => const WeatherInsights(),
profileSettings: (context) => const ProfileSettings(),
};
}
