import 'package:flutter/material.dart';
import '../profiles/profile_list_screen.dart';

// import '../splash/splash_screen.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {

  bool _hasAcceptedDisclaimer = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disclaimer'),
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
                value: _hasAcceptedDisclaimer,
                onChanged: (bool? value) {
                  if (value == true) {
                    setState(() {
                      _hasAcceptedDisclaimer = value ?? false;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _hasAcceptedDisclaimer
                    ? () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ProfileListScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}