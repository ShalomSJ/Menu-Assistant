import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isar/isar.dart';
import '/services/isar_database_service.dart';
import '../profiles/profile_list_screen.dart';
import '../../model/profile.dart';
import '../../model/food_allergy.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final Set<FoodAllergyCategory> _selectedAllergies = {};

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final String name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a profile name.')),
      );
      return;
    }

    final isar = await IsarDatabaseService().isar;

    final newProfile = Profile(
      id: Isar.autoIncrement,
      name: name,
      allergyCategory: _selectedAllergies.toList(),
    );

    await isar.writeTxn(() async {
      await isar.profiles.put(newProfile);
    });

    // TO SAVE THE LAST ACTIVITY IN SHARED PREFERENCES
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'last_activity', 
      _selectedAllergies.isNotEmpty ? _selectedAllergies.first.name : ''
    );

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ProfileListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Profile Name'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Food Allergies',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: FoodAllergyCategory.values.map((allergy) {
                final isSelected = _selectedAllergies.contains(allergy);
                return FilterChip(
                  label: Text(_formatEnumName(allergy.name)),
                  selected: isSelected,
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
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TO CAPITALIZE THE FIRST LETTER OF EACH WORD IN THE ENUM NAME
String _formatEnumName(String name) {
  if (name.isEmpty) return '';
  return name.split('_').map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

