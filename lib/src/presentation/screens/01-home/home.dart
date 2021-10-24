import 'package:flutter/material.dart';

import 'package:complex_ui/src/constants/routes.dart';

/// Displays a list of SampleItems.
class Home extends StatelessWidget {
  const Home({
    Key? key,
    required this.toggleDrawer,
  }) : super(key: key);
  final VoidCallback toggleDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex UI'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            toggleDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, homeRoute);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('New Template'),
      ),
    );
  }
}
