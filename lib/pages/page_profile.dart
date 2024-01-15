import 'package:flutter/material.dart';

final class PageProfile extends StatelessWidget {
  const PageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Profile'),
          Text('Your name'),
        ],
      ),
    );
  }
}
