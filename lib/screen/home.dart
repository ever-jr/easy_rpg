import 'package:easy_rpg/other/translator.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(),
      body: ListView(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (context) => const AlertDialog(
                  content: _CreateCampaign(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: Text('Create Campaign'.translateTo(Language.ptBR)),
          ),
        ],
      ),
    );
  }
}

class _CreateCampaign extends StatelessWidget {
  const _CreateCampaign();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          child: TextFormField(
            decoration: InputDecoration(
              label: Text('Campaign\'s name'.translateTo(Language.ptBR)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel),
                label: Text('Cancel'.translateTo(Language.ptBR)),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.movie_creation_outlined),
                label: Text('Create'.translateTo(Language.ptBR)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
