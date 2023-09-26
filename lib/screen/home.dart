import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: const [
          Card(
            child: ListTile(
              title: Text('Title example'),
              subtitle: Text('Subtitle test'),
            ),
          ),
        ],
      ),
    );
  }
}
