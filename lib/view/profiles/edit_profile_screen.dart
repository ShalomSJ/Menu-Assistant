import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/services/isar_database_service.dart';
import '../profiles/profile_list_screen.dart';
import '../../model/profile.dart';
import '../../model/food_allergy.dart';
import '../../controller/profile_controller.dart';
import 'create_profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final Profile profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Set<FoodAllergyCategory> _selectedAllergies;

  @override
  void initState() {
    super.initState();
    _selectedAllergies = widget.profile.allergyCategory.toSet();

    // TO CHECK OF NAME IS EMPTY AND REDIRECT TO CREATE PROFILE SCREEN
    if (widget.profile.name.trim().isEmpty) {
      WidgetsBinding.instance.addPersistentFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CreateProfileScreen(
              profileController: ProfileController(),
            ),
          ),
        );
      });
    }
  }


  // TO SAVE THE UPDATED PROFILE
  Future<void> _updateProfile() async {

    final isar = await IsarDatabaseService().isar;

    final updatedProfile = widget.profile
      ..allergyCategory = _selectedAllergies.toList();

    await isar.writeTxn(() async {
      await isar.profiles.put(updatedProfile);
    });
    
  
    // TO SAVE THE LAST ACTIVITY IN SHARED PREFERENCES
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'last_activity', 
      _selectedAllergies.isNotEmpty ? _selectedAllergies.first.name : ''
    );

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ProfileListScreen(
          profileController: ProfileController(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // TO CHECK IF THE PROFILE NAME IS EMPTY AND SHOW A LOADING INDICATOR
    if (widget.profile.name.trim().isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Profile Name',
                border: OutlineInputBorder(),
              ),
              child: Text(widget.profile.name, style: const TextStyle(fontSize: 16)),
            ),

             
            const SizedBox(height: 24),
            const Text('Select Allergies:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: FoodAllergyCategory.values.map((allergy) {
                return FilterChip(
                  label: Text(_formatEnumName(allergy.name)),
                  selected: _selectedAllergies.contains(allergy),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedAllergies.add(allergy);
                      } else {
                        _selectedAllergies.remove(allergy);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatEnumName(String name) {
  if (name.isEmpty) return '';
  return name[0].toUpperCase() + name.substring(1).toLowerCase();
}