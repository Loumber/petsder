// ignore_for_file: deprecated_member_use

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/data/models/indexed_selector_item/indexed_selector_item.dart';
import 'package:petsder/ui/widgets/common/indexed.dart';

class IndexedSelector extends StatelessWidget {
  const IndexedSelector({super.key, required this.items});
  final List<IndexedSelectorItem> items;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: context.theme.main.inputFieldBackgroundColor,
      ),
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 4,
        right: 3,
        left: 3,
      ),
      height: size.height * 0.05 + 8,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.biggest.width;
          final maxHeight = constraints.biggest.height;
          return Indexer(
            children: items.mapIndexed(
              (index, item) {
                final selected = item.selected;
                return Indexed(
                  index: selected ? 2 : 1,
                  child: Positioned(
                    left: index * (maxWidth - maxHeight * 0.5) * 0.5,
                    child: SizedBox(
                      width: (maxWidth + maxHeight * 0.5) * 0.5,
                      height: size.height * 0.05,
                      child: TextButton(
                        style: selected
                            ? ButtonStyle(
                                fixedSize: WidgetStateProperty.all<Size>(const Size(240, 55)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return context.theme.main.primary;
                                    }
                                    return context.theme.main.primary;
                                  },
                                ),
                              )
                            : ButtonStyle(
                                fixedSize: MaterialStateProperty.all<Size>(const Size(240, 55)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                splashFactory: NoSplash.splashFactory,
                              ),
                        onPressed: item.onClick,
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 18,
                            color: selected ? Colors.white : context.theme.main.inputFieldLabelColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
