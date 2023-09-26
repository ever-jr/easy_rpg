import 'package:easy_rpg/other/translator.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Name'.translateTo(Language.ptBR)),
              subtitle: const Text('subtitle'),
            ),
          ),
        ],
      ),
    );
  }
}
