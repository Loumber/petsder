import 'package:flutter/material.dart';
 

class AppLoadingErrorWidget extends StatelessWidget  {
  const AppLoadingErrorWidget({
    super.key
  });

  @override
  Widget build(context) {
    return const Scaffold(
      body: Center(
        child: Text('Упс...'),
      ),
    );
  }
}