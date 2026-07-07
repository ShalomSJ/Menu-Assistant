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
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _scannerController.addListener(_onControllerStateChanged);
    _scannerController.initializeApp();
  }

  @override
  void dispose() {
    _scannerController.removeListener(_onControllerStateChanged);
    _scannerController.dispose();
    super.dispose();
  }

  @override
  void _onControllerStateChanged() {
    if (!mounted) return;

    final target = _scannerController.navigationTarget;

    if (target == AppNavigationTarget.disclaimerScreen) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DisclaimerScreen()),
      );
    } else if (target == AppNavigationTarget.profileListScreen) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ProfileListScreen()),
      );
    } else if (target == AppNavigationTarget.createProfileScreen) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const CreateProfileScreen()),
      );
    }
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

