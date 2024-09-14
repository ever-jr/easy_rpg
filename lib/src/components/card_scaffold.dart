import 'package:flutter/material.dart';

class CardScaffold extends StatelessWidget {
  final AppBar? _appBar;
  final Widget _body;

  const CardScaffold({
    super.key,
    AppBar? appBar,
    required Widget body,
  })  : _appBar = appBar,
        _body = body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox.expand(
          child: Card(
            child: _body,
          ),
        ),
      ),
    );
  }
}
