import 'package:flutter/material.dart';

class IndexedSelectorItem {
  IndexedSelectorItem(this.title, this.onClick, {required this.selected});

  final bool selected;
  final String title;
  final VoidCallback onClick;
}