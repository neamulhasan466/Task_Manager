import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/forgot_passwoard_verify_otp_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswoardVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswoardVerifyEmailScreen({super.key});

  @override
  State<ForgotPasswoardVerifyEmailScreen> createState() => _ForgotPasswoardVerifyEmailScreenState();
}

class _ForgotPasswoardVerifyEmailScreenState extends State<ForgotPasswoardVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
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
                    'Your Email Address',
                    style: Theme.of (context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'A 6 digits OTP will be sent to your email address',
                    style: Theme.of (context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _emailTEController,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 16),

                  FilledButton(

                    onPressed:_onTapNextButton,
                    child: const Icon(Icons.arrow_right_outlined),
                  ),
                  const SizedBox(height: 36),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                        text: "Alrady have an account? ",
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapLoginButton,
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
  void _onTapLoginButton() {
    Navigator.pop(context);
  }
  void _onTapNextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswoardVerifyOtpScreen()),);
  }


  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
