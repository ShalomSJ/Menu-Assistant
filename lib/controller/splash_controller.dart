import 'dart:async';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/services/isar_database_service.dart';
import '../model/profile.dart';

enum AppNavigationTarget {
  splashScreen,
  disclaimerScreen,
  profileListScreen,
  createProfileScreen,
  editProfileScreen,
}

class ScannerController extends ChangeNotifier {
  AppNavigationTarget _navigationTarget = AppNavigationTarget.splashScreen;
  Timer? _splashTimer;

  AppNavigationTarget get navigationTarget => _navigationTarget;

  // TO START THE APP INITIALIZATION PROCESS
  void initializeApp() {
    _navigationTarget = AppNavigationTarget.splashScreen;
    notifyListeners();

    // TO START A TIMER FOR THE SPLASH SCREEN WHILE DATABASE IS INITIALIZING
    _splashTimer = Timer(const Duration(seconds: 3), () async {
      await _determineNextScreen();
    });
  }

  // TO EVALUATE 
  Future<void> _determineNextScreen() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final bool isDisclaimerAccepted = prefs.getBool('is_disclaimer_accepted') ?? false;

      if (isDisclaimerAccepted) {
        _navigationTarget = AppNavigationTarget.profileListScreen;
      } else {
        _navigationTarget = AppNavigationTarget.disclaimerScreen;
      }

      String lastActivity = prefs.getString('last_activity') ?? '';

      final isar = await IsarDatabaseService().isar;
      final allProfiles = await isar.profiles.where().findAll();

      final matchedProfiles = allProfiles.where((profile) {
        if (lastActivity.isEmpty) {
          return true; // Show all profiles if no last activity
        }
        return profile.allergyCategory.any((allergy) => allergy.name == lastActivity);
      }).toList();

      if (matchedProfiles.isEmpty) {
        _navigationTarget = AppNavigationTarget.createProfileScreen;
      } else {
        _navigationTarget = AppNavigationTarget.profileListScreen;
      }
    } catch (e) {
      // TO FALLBACK SAFE ROUTING TO CREATE PROFILE SCREEN IN CASE OF ANY ERROR
      _navigationTarget = AppNavigationTarget.createProfileScreen;
  }

  notifyListeners();
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    super.dispose();
  }
}