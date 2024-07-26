import 'package:flutter/material.dart';
import 'package:mindari_tree/mindari_tree.dart';

import 'app_controller.dart';
import 'node/tree_node_tile.dart';

class CustomTreeView extends StatefulWidget {
  const CustomTreeView({Key? key}) : super(key: key);

  @override
  _CustomTreeViewState createState() => _CustomTreeViewState();
}

class _CustomTreeViewState extends State<CustomTreeView> {
  @override
  Widget build(BuildContext context) {
    final appController = AppController.of(context);

    return ValueListenableBuilder<TreeViewTheme>(
      valueListenable: appController.treeViewTheme,
      builder: (_, treeViewTheme, __) {
        return Scrollbar(
          thumbVisibility: false,
          controller: appController.scrollController,
          child: TreeView(
            controller: appController.treeController,
            theme: treeViewTheme,
            scrollController: appController.scrollController,
            nodeHeight: appController.nodeHeight,
            nodeBuilder: (_, __) => const TreeNodeTile(),
          ),
        );
      },
    );
  }
}
