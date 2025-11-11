import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A compact app bar that places a back button and a drawer/menu button
/// on the left side, followed by the title. Designed to be a drop-in
/// replacement for AppBar in screens where both icons are required.
class LeftBackMenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double elevation;
  final Color? backgroundColor;

  const LeftBackMenuAppBar({
    Key? key,
    required this.title,
    this.elevation = 4.0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).primaryColor;
    final textStyle = Theme.of(context).appBarTheme.titleTextStyle ?? Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white);

    return Material(
      elevation: elevation,
      color: bg,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              // Left group: back + menu
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    tooltip: 'Back',
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                  ),
                  Builder(builder: (ctx) {
                    return IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      tooltip: 'Menu',
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    );
                  }),
                ],
              ),

              const SizedBox(width: 8),

              // Title
              DefaultTextStyle(
                style: textStyle ?? const TextStyle(color: Colors.white, fontSize: 20),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                child: Text(title),
              ),

              // Fill remaining space so layout looks like an AppBar
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
