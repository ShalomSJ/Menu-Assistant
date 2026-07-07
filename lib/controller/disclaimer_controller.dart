import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isar/isar.dart';
import '../services/isar_database_service.dart';
import '../model/profile.dart';

// TO DEFINE THE NAVIGATION TARGETS FOR THE DISCLAIMER SCREEN
enum DisclaimerNavigationTarget {
  profileListScreen,
  createProfileScreen,
}


class DisclaimerController extends ChangeNotifier {
  bool _hasAcceptedDisclaimer = false;

  DisclaimerNavigationTarget? _navigationTarget;


  // GETTERS TO ACCESS THE STATE VARIABLES
  bool get hasAcceptedDisclaimer => _hasAcceptedDisclaimer;
  DisclaimerNavigationTarget? get navigationTarget => _navigationTarget;

  void setDisclaimerAccepted(bool value) {
    _hasAcceptedDisclaimer = value;
    notifyListeners();
  }

  void rejectDisclaimer() {
    SystemNavigator.pop();
  }

  Future<void> handleDisclaimerSubmission(BuildContext context) async {
    if (!_hasAcceptedDisclaimer) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_disclaimer_accepted', true);

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
      _navigationTarget = DisclaimerNavigationTarget.createProfileScreen;
    } else {
      _navigationTarget = DisclaimerNavigationTarget.profileListScreen;
    }

    notifyListeners();
  }
}