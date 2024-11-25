import 'package:flutter/material.dart';

Widget parseJsonMessageToWidget(List<dynamic> message) {
  List<Widget> listWidgets = [];

  for (final text in message) {
    if (text is String) {
      listWidgets.add(Text(text));

    } else if (text is Map<String, dynamic> && text.containsKey("type")) {
      final String type = text["type"];
      final String msg = text["value"].toString();

      Color color = Colors.white;

      switch (type) {
        case "user":
          color = Colors.yellow;
          break;
        
        case "damage":
          color = Colors.red;
          break;

        case "item":
          color = Colors.green;
          break;
        
        case "dice":
          color = Colors.grey;
          break;

        case "dice_result":
          color = Colors.blue;
          break;
          
        case "character":
          color = Colors.black;
          break;

        case "attribute":
          color = Colors.purple;
          break;
      }

      listWidgets.add(Text(
        msg,
        style: TextStyle(color: color),
      ));
    }
  }

  return Wrap(spacing: 10, children: listWidgets);
}

class ChatPage extends StatefulWidget {
  static const String routeName = "/chat";
  static const double _messagePadding = 8;
  

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _inputController = TextEditingController();
  final messages = [
    [
      {"type": "user", "value": "J'Zargo"},
      "rolled the",
      {"type": "dice", "value": 20},
      "result: ",
      {"type": "dice_result", "value": 11}
    ],
    [
      {"type": "user", "value": "J'Zargo"},
      "used the",
      {"type": "item", "value": "Fire Sword"},
    ],
    [
      {"type": "character", "value": "Goblin"},
      "received",
      {"type": "damage", "value": -10},
      {"type": "attribute", "value": "Health"},
    ],
  ];


  void _submitInput(String message) {
    setState(() {
      messages.add([message]);
      _inputController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.separated(
          itemCount: messages.length,
          itemBuilder: (_, index) => ChatMessage(
            child: parseJsonMessageToWidget(messages[index]),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: ChatPage._messagePadding),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _inputController,
                onSubmitted: _submitInput,
              ),
            ),
            ElevatedButton(
              onPressed: () => _submitInput(_inputController.text),
              child: const Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final Widget child;
  const ChatMessage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class User {
  final String name;
  final Color color;

  const User({
    required this.name,
    this.color = Colors.white,
  });
}

class Message {
  final User user;
  final String text;

  const Message({
    required this.user,
    required this.text,
  });
}

