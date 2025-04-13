import 'package:easy_rpg/models/player.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.playerNotifier});

  final PlayerNotifier playerNotifier;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  void tryLogin() {
    print("""
-Login-
    id: ${idFieldController.text}
    password: ${passwordFieldController.text}
    """);
    widget.playerNotifier.setPlayer(const Identifier(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width:  412,
          height: 256,
          child: Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Title(
                        title: "Login",
                        color: Colors.white,
                        child: const Text("Login"),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("id: "),
                        const Spacer(),
                        SizedBox(
                          width: 200,
                          child: TextField(controller: idFieldController),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("password: "),
                        const Spacer(),
                        SizedBox(
                          width: 200,
                          child: TextField(controller: passwordFieldController),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: ElevatedButton(
                        onPressed: () {
                          tryLogin();
                        },
                        child: const Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}