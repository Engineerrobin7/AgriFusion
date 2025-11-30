import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/agricultural_alerts_widget.dart';
import './widgets/current_weather_card.dart';
import './widgets/hourly_forecast_widget.dart';
import './widgets/location_header_widget.dart';
import './widgets/weather_actions_widget.dart';
import './widgets/weekly_forecast_widget.dart';

class WeatherInsights extends StatefulWidget {
  const WeatherInsights({super.key});

  @override
  State<WeatherInsights> createState() => _WeatherInsightsState();
}

class _WeatherInsightsState extends State<WeatherInsights>
    with TickerProviderStateMixin {
  late TabController _tabController;
  
  String _currentLocation = "Pune, Maharashtra";
  String _lastUpdated = "2 minutes ago";

  // Mock weather data
  final Map<String, dynamic> _currentWeatherData = {
    "temperature": 28,
    "feelsLike": 32,
    "condition": "Partly Cloudy",
    "icon": "wb_cloudy",
    "humidity": 65,
    "windSpeed": 12,
    "rainfall": 0,
    "uvIndex": 6,
  };

  final List<Map<String, dynamic>> _hourlyForecastData = [
    {
      "time": "12 PM",
      "temperature": 28,
      "icon": "wb_cloudy",
      "precipitation": 10,
    },
    {
      "time": "1 PM",
      "temperature": 30,
      "icon": "wb_sunny",
      "precipitation": 5,
    },
    {
      "time": "2 PM",
      "temperature": 32,
      "icon": "wb_sunny",
      "precipitation": 0,
    },
    {
      "time": "3 PM",
      "temperature": 33,
      "icon": "wb_sunny",
      "precipitation": 0,
    },
    {
      "time": "4 PM",
      "temperature": 31,
      "icon": "wb_cloudy",
      "precipitation": 15,
    },
    {
      "time": "5 PM",
      "temperature": 29,
      "icon": "cloud",
      "precipitation": 25,
    },
    {
      "time": "6 PM",
      "temperature": 27,
      "icon": "cloud",
      "precipitation": 40,
    },
    {
      "time": "7 PM",
      "temperature": 25,
      "icon": "grain",
      "precipitation": 60,
    },
  ];

  final List<Map<String, dynamic>> _weeklyForecastData = [
    {
      "day": "Today",
      "date": "Oct 22",
      "high": 33,
      "low": 22,
      "icon": "wb_cloudy",
      "rainfall": 2,
    },
    {
      "day": "Tomorrow",
      "date": "Oct 23",
      "high": 31,
      "low": 20,
      "icon": "grain",
      "rainfall": 15,
    },
    {
      "day": "Thursday",
      "date": "Oct 24",
      "high": 29,
      "low": 19,
      "icon": "thunderstorm",
      "rainfall": 25,
    },
    {
      "day": "Friday",
      "date": "Oct 25",
      "high": 27,
      "low": 18,
      "icon": "cloud",
      "rainfall": 8,
    },
    {
      "day": "Saturday",
      "date": "Oct 26",
      "high": 30,
      "low": 21,
      "icon": "wb_sunny",
      "rainfall": 0,
    },
    {
      "day": "Sunday",
      "date": "Oct 27",
      "high": 32,
      "low": 23,
      "icon": "wb_sunny",
      "rainfall": 0,
    },
    {
      "day": "Monday",
      "date": "Oct 28",
      "high": 34,
      "low": 24,
      "icon": "wb_cloudy",
      "rainfall": 3,
    },
  ];

  final List<Map<String, dynamic>> _agriculturalAlerts = [
    {
      "type": "warning",
      "title": "High Temperature Alert",
      "description":
          "Temperatures above 32°C expected. Increase irrigation frequency for sensitive crops. Avoid spraying during peak hours.",
      "time": "2 hours ago",
    },
    {
      "type": "info",
      "title": "Optimal Planting Window",
      "description":
          "Weather conditions are favorable for sowing winter crops. Soil moisture levels are adequate for germination.",
      "time": "6 hours ago",
    },
    {
      "type": "success",
      "title": "Good Spraying Conditions",
      "description":
          "Low wind speed and moderate humidity make it ideal for pesticide application between 6-8 AM tomorrow.",
      "time": "1 day ago",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this, initialIndex: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshWeatherData() async {
    setState(() {
    
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      
      _lastUpdated = "Just now";
    });

    Fluttertoast.showToast(
      msg: "Weather data updated successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _onLocationTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildLocationSelector(),
    );
  }

  Widget _buildLocationSelector() {
    final List<String> locations = [
      "Pune, Maharashtra",
      "Mumbai, Maharashtra",
      "Nashik, Maharashtra",
      "Aurangabad, Maharashtra",
      "Nagpur, Maharashtra",
    ];

    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 12.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.dividerLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: Text(
              'Select Location',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryLight,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemBuilder: (context, index) {
                final location = locations[index];
                final isSelected = location == _currentLocation;

                return ListTile(
                  leading: CustomIconWidget(
                    iconName: isSelected ? 'location_on' : 'location_city',
                    size: 6.w,
                    color: isSelected
                        ? AppTheme.primaryLight
                        : AppTheme.textSecondaryLight,
                  ),
                  title: Text(
                    location,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.primaryLight
                          : AppTheme.textPrimaryLight,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  trailing: isSelected
                      ? CustomIconWidget(
                          iconName: 'check_circle',
                          size: 5.w,
                          color: AppTheme.primaryLight,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      _currentLocation = location;
                    });
                    Navigator.pop(context);
                    _refreshWeatherData();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onMapsTap() {
    Fluttertoast.showToast(
      msg: "Opening weather maps...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _onHistoryTap() {
    Fluttertoast.showToast(
      msg: "Loading historical weather data...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _onShareTap() {
    Fluttertoast.showToast(
      msg: "Sharing weather update with community...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _onSettingsTap() {
    Fluttertoast.showToast(
      msg: "Opening notification settings...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Column(
        children: [
          LocationHeaderWidget(
            location: _currentLocation,
            lastUpdated: _lastUpdated,
            onLocationTap: _onLocationTap,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshWeatherData,
              color: AppTheme.primaryLight,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    CurrentWeatherCard(weatherData: _currentWeatherData),
                    HourlyForecastWidget(hourlyData: _hourlyForecastData),
                    WeeklyForecastWidget(weeklyData: _weeklyForecastData),
                    AgriculturalAlertsWidget(alerts: _agriculturalAlerts),
                    WeatherActionsWidget(
                      onMapsTap: _onMapsTap,
                      onHistoryTap: _onHistoryTap,
                      onShareTap: _onShareTap,
                      onSettingsTap: _onSettingsTap,
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: CustomIconWidget(
                  iconName: 'language',
                  size: 6.w,
                  color: _tabController.index == 0
                      ? AppTheme.primaryLight
                      : AppTheme.textSecondaryLight,
                ),
                text: 'Language',
              ),
              Tab(
                icon: CustomIconWidget(
                  iconName: 'mic',
                  size: 6.w,
                  color: _tabController.index == 1
                      ? AppTheme.primaryLight
                      : AppTheme.textSecondaryLight,
                ),
                text: 'Voice',
              ),
              Tab(
                icon: CustomIconWidget(
                  iconName: 'wb_cloudy',
                  size: 6.w,
                  color: _tabController.index == 2
                      ? AppTheme.primaryLight
                      : AppTheme.textSecondaryLight,
                ),
                text: 'Weather',
              ),
              Tab(
                icon: CustomIconWidget(
                  iconName: 'camera_alt',
                  size: 6.w,
                  color: _tabController.index == 3
                      ? AppTheme.primaryLight
                      : AppTheme.textSecondaryLight,
                ),
                text: 'Camera',
              ),
              Tab(
                icon: CustomIconWidget(
                  iconName: 'chat',
                  size: 6.w,
                  color: _tabController.index == 4
                      ? AppTheme.primaryLight
                      : AppTheme.textSecondaryLight,
                ),
                text: 'History',
              ),
              Tab(
                icon: CustomIconWidget(
                  iconName: 'person',
                  size: 6.w,
                  color: _tabController.index == 5
                      ? AppTheme.primaryLight
                      : AppTheme.textSecondaryLight,
                ),
                text: 'Profile',
              ),
            ],
            onTap: (index) {
              if (index != 2) {
                final routes = [
                  '/language-selection',
                  '/voice-query',
                  '/weather-insights',
                  '/camera-diagnosis',
                  '/chat-history',
                  '/profile-settings',
                ];
                Navigator.pushNamed(context, routes[index]);
              }
            },
            labelColor: AppTheme.primaryLight,
            unselectedLabelColor: AppTheme.textSecondaryLight,
            indicatorColor: AppTheme.primaryLight,
            labelStyle: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle:
                AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
