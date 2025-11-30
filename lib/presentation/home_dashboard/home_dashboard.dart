import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/bottom_navigation_widget.dart';
import './widgets/farm_stats_widget.dart';
import './widgets/government_schemes_widget.dart';
import './widgets/greeting_widget.dart';
import './widgets/quick_actions_widget.dart';
import './widgets/recent_activity_widget.dart';
import './widgets/recommendations_widget.dart';
import './widgets/weather_summary_widget.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  bool _isOffline = false;
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _checkConnectivity();
    _loadDashboardData();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (mounted) {
      setState(() {
        _isOffline = connectivityResult.contains(ConnectivityResult.none);
      });
    }
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);

    try {
      // Simulate data loading
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        Fluttertoast.showToast(
          msg: "Failed to load dashboard data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  Future<void> _onRefresh() async {
    if (kIsWeb) {
      // Web haptic feedback alternative
      await Future.delayed(const Duration(milliseconds: 50));
    } else {
      // Mobile haptic feedback would go here
    }

    await _checkConnectivity();
    await _loadDashboardData();

    Fluttertoast.showToast(
      msg: "Dashboard updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _onVoiceQuery() {
    _fabAnimationController.forward().then((_) {
      _fabAnimationController.reverse();
    });

    Navigator.pushNamed(context, AppRoutes.voiceQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.primary,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                'AgriFusion',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              centerTitle: false,
              actions: [
                if (_isOffline)
                  Container(
                    margin: EdgeInsets.only(right: 4.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.cloud_off, size: 16, color: Colors.orange),
                        SizedBox(width: 1.w),
                        Text(
                          'Offline',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    // Handle notifications
                  },
                ),
              ],
            ),

            // Dashboard Content
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              sliver: _isLoading
                  ? SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Loading your dashboard...',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate([
                        // Greeting Section
                        const GreetingWidget(),
                        SizedBox(height: 2.h),

                        // Weather Summary
                        const WeatherSummaryWidget(),
                        SizedBox(height: 2.h),

                        // Quick Actions
                        const QuickActionsWidget(),
                        SizedBox(height: 2.h),

                        // Government Schemes Banner
                        const GovernmentSchemesWidget(),
                        SizedBox(height: 2.h),

                        // Today's Recommendations
                        const RecommendationsWidget(),
                        SizedBox(height: 2.h),

                        // Farm Statistics
                        const FarmStatsWidget(),
                        SizedBox(height: 2.h),

                        // Recent Activity
                        const RecentActivityWidget(),
                        SizedBox(height: 10.h), // Space for FAB
                      ]),
                    ),
            ),
          ],
        ),
      ),

      // Floating Action Button for Voice Query
      floatingActionButton: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(
              parent: _fabAnimationController, curve: Curves.easeInOut),
        ),
        child: FloatingActionButton.extended(
          onPressed: _onVoiceQuery,
          icon: const Icon(Icons.mic, size: 24),
          label: Text(
            'Ask AgriFusion',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 6,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // Bottom Navigation
      bottomNavigationBar: const HomeDashboardBottomNavigation(),
    );
  }
}
