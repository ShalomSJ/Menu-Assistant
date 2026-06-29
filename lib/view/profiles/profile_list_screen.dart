import 'package:flutter/material.dart';

class ProfileListScreen extends StatelessWidget {
  const ProfileListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles'),
      ),
      body: const Center(
        child: Text("Who's eating today?"),
      ),
    );
  }
}

