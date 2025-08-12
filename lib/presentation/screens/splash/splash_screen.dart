import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chargerrr/core/theme/app_theme.dart';
import 'package:chargerrr/core/utils/app_constants.dart';
import 'package:chargerrr/presentation/screens/splash/splash_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    return status.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 120,
              height: 120,
            ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),

            const SizedBox(height: 24),

            // App Name
            Text(
                  AppConstants.appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.2, end: 0),

            const SizedBox(height: 8),

            // Tagline
            Text(
              AppConstants.appTagline,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ).animate().fadeIn(delay: 800.ms, duration: 600.ms),

            const SizedBox(height: 48),

            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }
}
