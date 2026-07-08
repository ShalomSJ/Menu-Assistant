import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile.dart';
import '../model/food_allergy.dart';
import '../services/isar_database_service.dart';

class ProfileController extends ChangeNotifier {
  ProfileController() {
    // Eager load can be triggered by screens if desired.
  }

  bool _isLoading = false;
  List<Profile> _profiles = const [];

  bool get isLoading => _isLoading;
  List<Profile> get profiles => _profiles;

  /// Loads profiles from Isar, optionally filtering by `last_activity`.
  /// - If `last_activity` is empty, loads all profiles.
  /// - If it is set, loads profiles containing that allergy category.
  Future<void> loadProfiles({bool filterByLastActivity = true}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final lastActivity = prefs.getString('last_activity') ?? '';

      final isar = await IsarDatabaseService().isar;
      final allProfiles = await isar.profiles.where().findAll();

      if (!filterByLastActivity || lastActivity.isEmpty) {
        _profiles = allProfiles;
      } else {
        _profiles = allProfiles
            .where(
              (profile) => profile.allergyCategory.any(
                (allergy) => allergy.name == lastActivity,
              ),
            )
            .toList();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Creates a new profile and persists it.
  /// Also updates `last_activity` to the first selected allergy.
  Future<Profile> createProfile({
    required String name,
    required Set<FoodAllergyCategory> selectedAllergies,
  }) async {
    final trimmed = name.trim();

    if (trimmed.isEmpty) {
      throw ArgumentError('Profile name cannot be empty');
    }

    final isar = await IsarDatabaseService().isar;

    final newProfile = Profile(
      id: Isar.autoIncrement,
      name: trimmed,
      allergyCategory: selectedAllergies.toList(),
    );

    await isar.writeTxn(() async {
      await isar.profiles.put(newProfile);
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'last_activity',
      selectedAllergies.isNotEmpty ? selectedAllergies.first.name : '',
    );

    return newProfile;
  }

  /// Updates an existing profile and persists it.
  /// Also updates `last_activity` to the first selected allergy.
  Future<void> updateProfile({
    required Profile profile,
    required Set<FoodAllergyCategory> selectedAllergies,
  }) async {
    final isar = await IsarDatabaseService().isar;

    profile.allergyCategory = selectedAllergies.toList();

    await isar.writeTxn(() async {
      await isar.profiles.put(profile);
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'last_activity',
      selectedAllergies.isNotEmpty ? selectedAllergies.first.name : '',
    );

    // Keep cached profiles consistent with filtering.
    await loadProfiles(filterByLastActivity: true);
  }

  /// Deletes a profile by id.
  Future<void> deleteProfile(Id id) async {
    final isar = await IsarDatabaseService().isar;
    await isar.writeTxn(() async {
      await isar.profiles.delete(id);
    });

    await loadProfiles(filterByLastActivity: true);
  }

  /// Helper to format enum names (e.g., `cowmilk` -> `Cowmilk`,
  /// `tree_nuts` -> `Tree Nuts`).
  String formatEnumName(String name) {
    if (name.isEmpty) return '';
    return name
        .split('_')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}

