import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ResetPasswoardScreen extends StatefulWidget {
  const ResetPasswoardScreen({super.key});

  @override
  State<ResetPasswoardScreen> createState() => _ResetPasswoardScreenState();
}

class _ResetPasswoardScreenState extends State<ResetPasswoardScreen> {
  final TextEditingController _passwoardTEController = TextEditingController();
  final TextEditingController _confirmPasswoardTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 82),
                  Text(
                    'Reset Passwoard',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Passwoard should be more than 6 letters and combination of numbers',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _passwoardTEController,
                    decoration: InputDecoration(hintText: 'New Passwoard'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPasswoardTEController,
                    decoration: InputDecoration(
                      hintText: 'Confirm New Passwoard',
                    ),
                  ),
                  const SizedBox(height: 16),

                  FilledButton(
                    onPressed: _onTapResetPasswoardButton,
                    child: Text('Confirm'),
                  ),
                  const SizedBox(height: 36),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        text: "Alrady have an account? ",
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSingUpButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSingUpButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (predicate) => false,
    );
  }

  void _onTapResetPasswoardButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (predicate) => false,
    );
  }

  @override
  void dispose() {
    _passwoardTEController.dispose();
    _confirmPasswoardTEController.dispose();
    super.dispose();
  }
}
