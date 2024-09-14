import 'package:flutter/material.dart';

List<String> messages = [
  "J'Zargo rolled the 20 dice...\nresult: 11",
  "J'Zargo used Fire Sword",
  "Goblin received -10 Health",
  "Goblin died!",
  "J'Zargo received 1 Dagger, 10 Gold",
  "J'Zargo\nAy! that's nice",
];

class ChatPage extends StatelessWidget {
  static const String routeName = "/chat";
  static const double _messagePadding = 8;

  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.separated(
          itemCount: messages.length,
          itemBuilder: (_, index) => ChatMessage(messages[index]),
          separatorBuilder: (_, __) => const SizedBox(height: _messagePadding),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            const Flexible(
              child: TextField(),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: const Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String _message;
  const ChatMessage(
    String message, {
    super.key,
  }) : _message = message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(_message),
      ),
    );
  }
}
