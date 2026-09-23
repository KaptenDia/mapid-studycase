import 'package:flutter/material.dart';
import 'package:baseproject_flutter/module/onboarding/presentation/onboarding_screen.dart';
import 'package:baseproject_flutter/helper/navigator.dart';
import 'package:baseproject_flutter/shared/widget/logo/app_logo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }

      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
    } catch (e) {
      // Ignore errors if location services are completely unavailable
    }

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      navigator.pushReplacement(const OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AppLogo(size: LogoSize.xlarge),
      ),
    );
  }
}
