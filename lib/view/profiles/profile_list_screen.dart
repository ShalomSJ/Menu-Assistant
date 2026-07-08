import 'package:flutter/material.dart';
import '../../controller/profile_controller.dart';
import '../profiles/create_profile_screen.dart';

class ProfileListScreen extends StatefulWidget {
  final ProfileController profileController;

  const ProfileListScreen({super.key, required this.profileController});

  @override
  State<ProfileListScreen> createState() => _ProfileListScreenState();
}
 
class _ProfileListScreenState extends State<ProfileListScreen> {
  @override
  void initState() {
    super.initState();
    widget.profileController.loadProfiles(filterByLastActivity: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
        ),
      body: ListenableBuilder(
        listenable: widget.profileController, 
        builder: (context, _) {
          if (widget.profileController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.profileController.profiles.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateProfileScreen(profileController: widget.profileController),
                ),
              );
            });
            return const Center(child: Text('No profiles found. Redirecting to create a new profile...'));
          }

          return ListView.builder(
            itemCount: widget.profileController.profiles.length,
            itemBuilder: (context, index) {
              final profile = widget.profileController.profiles[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: CircleAvatar(
                    // TO DISPLAY THE FIRST LETTER OF THE PROFILE NAME
                    child: Text(profile.name.isNotEmpty ? profile.name[0] : '?'), 
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
                            return Chip(
                              label: Text(
                                widget.profileController.formatEnumName(allergy.name),
                                style: const TextStyle(fontSize: 12.0, color: Colors.redAccent),
                              ),
                              backgroundColor: Colors.red.shade50,
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
          );
        },
      ),
    );
  }
}
