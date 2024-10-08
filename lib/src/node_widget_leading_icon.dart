import 'package:flutter/material.dart';

import 'tree_node_scope.dart';

/// A widget to expand/collapse the [TreeNode] within the nearest [TreeNodeScope].
class NodeWidgetLeadingIcon extends StatelessWidget {
  /// A [Key] for the [expandIcon], necessary for flutter to know which widget
  /// to replace when animating.
  static const kExpandIconKey = ValueKey('#tree_view_expandIcon_key');

  /// The default icon used when a [TreeNode] is collapsed and it is not a Leaf.
  static const kExpandIcon = Icon(
    Icons.folder_rounded,
    key: kExpandIconKey,
  );

  /// A [Key] for [collapseIcon], necessary for flutter to know which widget
  /// to replace when animating.
  static const kCollapseIconKey = ValueKey('#tree_view_collapseIcon_key');

  /// The default icon used when a [TreeNode] is expanded and it is not a Leaf.
  static const kCollapseIcon = Icon(
    Icons.folder_open_rounded,
    key: kCollapseIconKey,
  );

  /// Creates a [NodeWidgetLeadingIcon].
  ///
  /// If you're using custom icons for [expandIcon] or [collapseIcon], make
  /// sure to give them [Key]s so that flutter animates the swap correctly.
  ///
  /// Take a look at [NodeWidgetLeadingIcon.kExpandIconKey] and
  /// [NodeWidgetLeadingIcon.kCollapseIconKey].
  ///
  /// The [leafIcon] don't need a key as it doesn't get animated.
  const NodeWidgetLeadingIcon({
    super.key,
    this.expandIcon,
    this.collapseIcon,
    this.leafIcon = const Icon(Icons.article_rounded),
    this.padding = const EdgeInsets.all(8.0),
    this.useFoldersOnly = false,
    this.leafIconDisabledColor,
    this.splashRadius,
    this.onPressed,
  });

  /// Callback fired when the icon is pressed.
  ///
  /// When the node has children, it is automatically expanded/collapsed and
  /// this callback is called right after it.
  final VoidCallback? onPressed;

  /// The icon displayed when [TreeNodeScope.node] is collapsed and
  /// is not a Leaf. Defaults to [NodeWidgetLeadingIcon.kExpandIcon].
  ///
  /// If you use a custom [expandIcon], make sure to give it a [Key] so that
  /// flutter animates the widget swap correctly. You can use the default key:
  /// [NodeWidgetLeadingIcon.kExpandIconKey].
  final Widget? expandIcon;

  /// The icon displayed when [TreeNodeScope.node] is collapsed and
  /// is not a Leaf. Defaults to [NodeWidgetLeadingIcon.kCollapseIcon].
  ///
  /// If you use a custom [collapseIcon], make sure to give it a [Key] so that
  /// flutter animates the widget swap correctly. You can use the default key:
  /// [NodeWidgetLeadingIcon.kCollapseIconKey].
  final Widget? collapseIcon;

  /// The icon displayed when [TreeNodeScope.node] is a Leaf.
  /// Defaults to [NodeWidgetLeadingIcon.kLeafIcon].
  final Widget leafIcon;

  /// The padding around the button's icon. The entire padded icon will react
  /// to input gestures.
  final EdgeInsetsGeometry padding;

  /// If set to `true`, [leafIcon] will be ignored and every
  /// [TreeNodeScope.node] will be expandable, even nodes without children.
  final bool useFoldersOnly;

  /// The color used by [leafIcon] when it's [IconButton] is disabled
  /// (i.e. [onPressed] is `null`).
  final Color? leafIconDisabledColor;

  /// The splash radius used in [IconButton].
  ///
  /// If null, default splash radius of [Material.defaultSplashRadius] is used.
  final double? splashRadius;

  @override
  Widget build(BuildContext context) {
    final treeNodeScope = TreeNodeScope.of(context);

    if (!useFoldersOnly && treeNodeScope.node.isLeaf) {
      return IconButton(
        splashRadius: splashRadius,
        padding: padding,
        disabledColor: leafIconDisabledColor,
        icon: leafIcon,
        onPressed: onPressed,
      );
    }
    return IconButton(
      splashRadius: splashRadius,
      padding: padding,
      onPressed: () {
        treeNodeScope.toggleExpanded(context);
        onPressed?.call();
      },
      icon: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        switchInCurve: Curves.fastOutSlowIn,
        switchOutCurve: Curves.fastOutSlowIn,
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: treeNodeScope.isExpanded
            ? collapseIcon ?? kCollapseIcon
            : expandIcon ?? kExpandIcon,
      ),
    );
  }
}
