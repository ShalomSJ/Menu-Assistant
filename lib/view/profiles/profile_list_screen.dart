import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isar/isar.dart';
import '../../model/profile.dart';
import '../../model/food_allergy.dart';
import '../../services/isar_database_service.dart';
import '../profiles/create_profile_screen.dart';

class ProfileListScreen extends StatefulWidget {
  const ProfileListScreen({super.key});

  @override
  State<ProfileListScreen> createState() => _ProfileListScreenState();
}
 
class _ProfileListScreenState extends State<ProfileListScreen> {
  List<Profile> _presavedProfiles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPresavedProfiles();
  }

  // TO LOAD PRESAVED PROFILES FROM ISAR DATABASE AND FILTER BASED ON LAST ACTIVITY
  Future<void> _loadPresavedProfiles() async {
    final prefs = await SharedPreferences.getInstance();

    // TO FETCH THE LAST ACTIVITY
    String lastActivity = prefs.getString('last_activity') ?? '';

    // TO FETCH THE PRESAVED PROFILES
    final isar = await IsarDatabaseService().isar;
    final allProfiles = await isar.profiles.where().findAll();

    setState(() {
      if (lastActivity.isEmpty) {

        // IF THERE IS NO LAST ACTIVITY, SHOW ALL PROFILES
        _presavedProfiles = allProfiles;
      } else {

        // IF THERE IS A LAST ACTIVITY, FILTER PROFILES BASED ON IT
        _presavedProfiles = allProfiles.where((profile) {
          return profile.allergyCategory.any((allergy) => allergy.name == lastActivity);
        }).toList();
      }
      _isLoading = false;
    });

    // TO REDIRECT IF THE LIST IS EMPTY
    if (_presavedProfiles.isEmpty) {
      WidgetsBinding.instance.addPersistentFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CreateProfileScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profiles',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _presavedProfiles.isEmpty
              ? const Center(child: Text('No profiles found. Redirecting to create a new profile...'))
              : ListView.builder(
                  itemCount: _presavedProfiles.length,
                  itemBuilder: (context, index) {
                    final profile = _presavedProfiles[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          // TO DISPLAY THE FIRST LETTER OF THE PROFILE NAME
                          child: Text(profile.name[0]), 
                        ),
                        title: Text(profile.name),
                        subtitle: profile.allergyCategory.isEmpty
                            ? const Text('No allergies listed')
                            : Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Wrap(
                                spacing: 4.0,
                                runSpacing: 2.0,
                                children: profile.allergyCategory.map((allergy) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(color: Colors.red.shade300),
                                    ),
                                    child: Text(
                                      _formatEnumName(allergy.name),
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {
                          // Handle profile selection
                        },
                      ),
                      );
                    },
                ),
    );
  }

  // TO CAPITALIZE THE FIRST LETTER OF EACH WORD IN THE ENUM NAME
  String _formatEnumName(String name) {
    if (name.isEmpty) return '';
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }
}

