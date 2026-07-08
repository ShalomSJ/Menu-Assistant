import 'package:flutter/material.dart';
import '../../controller/disclaimer_controller.dart';
import '../../controller/profile_controller.dart';
import '../profiles/profile_list_screen.dart';
import '../profiles/create_profile_screen.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {

  final DisclaimerController _disclaimerController = DisclaimerController();
  final ProfileController _profileController = ProfileController();

  @override
  void initState() {
    super.initState();
    _disclaimerController.addListener(_onControllerStateChanged);
  }

  @override
  void dispose() {
    _disclaimerController.removeListener(_onControllerStateChanged);
    _disclaimerController.dispose();
    _profileController.dispose();
    super.dispose();
  }

  void _onControllerStateChanged() {
    if (!mounted) return;

    final target = _disclaimerController.navigationTarget;

    if (target == DisclaimerNavigationTarget.profileListScreen) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ProfileListScreen(profileController: _profileController)),
      );
    } else if (target == DisclaimerNavigationTarget.createProfileScreen) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CreateProfileScreen(profileController: _profileController)),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _disclaimerController, 
      builder: (context, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Disclaimer'),
          automaticallyImplyLeading: false, // TO REMOVE THE BACK BUTTON
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Disclaimer\n\n',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'This application analyses restaurant menus for potential allergens and dietary restrictions.',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Please use it responsibly and consult with a healthcare professional for any medical concerns.',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.red.shade400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Always confirm with the restaurant staff regarding ingredients and preparation methods before ordering.',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.red.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),                  
                  ),
                ),

                const SizedBox(height: 20),

                CheckboxListTile(
                  title: Text(
                    'I have read and accept the terms, conditions and medical disclaimer.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: _disclaimerController.hasAcceptedDisclaimer,
                  onChanged: (bool? value) {
                    _disclaimerController.setDisclaimerAccepted(value ?? false);

                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _disclaimerController.rejectDisclaimer,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text('Reject & Exit'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _disclaimerController.hasAcceptedDisclaimer
                            ? () => _disclaimerController.handleDisclaimerSubmission(context)
                            : null,
                        child: const Text('Accept & Continue'),
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
  }
}