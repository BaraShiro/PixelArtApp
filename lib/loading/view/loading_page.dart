import 'package:flutter/material.dart';

/// A loading page that is shown while retrieving data from a repository.
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoadingPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
          child: CircularProgressIndicator()
    );
  }
}