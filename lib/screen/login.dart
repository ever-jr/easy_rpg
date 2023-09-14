import 'package:easy_rpg/screen/screen.dart';
import 'package:easy_rpg/widget/app_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends Screen {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(),
              _Input.email(),
              _Input.password(),
              const _Button(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Input({
    required this.icon,
    required this.label,
  });

  factory _Input.email() => const _Input(icon: Icons.person, label: 'Email');

  factory _Input.password() =>
      const _Input(icon: Icons.lock, label: 'Password');

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Icon(Icons.start),
    );
  }
}

class _SignInWithGoogleButton extends StatelessWidget {
  const _SignInWithGoogleButton();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
