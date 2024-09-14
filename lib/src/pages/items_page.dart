import 'package:easy_rpg/src/components/card_scaffold.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  static const String routeName = '/items';

  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Item example'),
              onTap: () {},
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CreateItemPage(),
                ));
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class CreateItemPage extends StatelessWidget {
  const CreateItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CardScaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 16,
          runSpacing: 16,
          children: [
            const Field(label: 'Icon', size: "small"),
            const Field(label: 'Name', size: "big"),
            const Field(label: 'Notification on use', size: "fill"),
            const Field(label: 'Description', size: "fill"),
            ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                width: double.infinity,
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  final String label;
  final String size;

  const Field({
    super.key,
    required this.label,
    this.size = "medium",
  });

  double defineSize(String sizeType) {
    switch (sizeType) {
      case "small":
        return 60;
      case "medium":
        return 120;
      case "big":
        return 260;
      case "fill":
      default:
        return double.infinity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: defineSize(size),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
