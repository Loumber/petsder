import 'package:flutter/material.dart';
 

class FindErrorWidget extends StatelessWidget  {
  const FindErrorWidget({
    super.key
  });

  @override
  Widget build(context) {
    return const Scaffold(
      body: Center(
        child: Text('Не удалось никого найти поблизости'),
      ),
    );
  }
}