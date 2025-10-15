import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Get Started With'),
            TextFormField(),
            TextFormField(),
            FilledButton(
              onPressed: () {},
              child: Icon(Icons.arrow_right_outlined),
            ),
            TextButton(onPressed: () {}, child: Text('Forget Passwoard?')),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                text: "Don't have an account",
                children: [TextSpan(text: 'Sign up')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
