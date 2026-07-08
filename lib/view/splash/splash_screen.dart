import 'package:flutter/material.dart';
import '../../controller/splash_controller.dart';
import '../profiles/profile_list_screen.dart';
import '../profiles/create_profile_screen.dart';
import '../disclaimer/disclaimer_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenController _splashScreenController = SplashScreenController();

  @override
  void initState() {
    super.initState();
    _splashScreenController.addListener(_onControllerStateChanged);
    _splashScreenController.initializeApp();
  }

  @override
  void dispose() {
    _splashScreenController.removeListener(_onControllerStateChanged);
    _splashScreenController.dispose();
    super.dispose();
  }

  void _onControllerStateChanged() {
    if (!mounted) return;

    final target = _splashScreenController.navigationTarget;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (target == AppNavigationTarget.disclaimerScreen) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DisclaimerScreen()),
        );
      } else if (target == AppNavigationTarget.profileListScreen) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfileListScreen(
              profileController: _splashScreenController.profileController,
            ),
          ),
        );
      } else if (target == AppNavigationTarget.createProfileScreen) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => CreateProfileScreen(
              profileController: _splashScreenController.profileController,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

