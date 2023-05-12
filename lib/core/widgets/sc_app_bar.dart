import 'package:flutter/material.dart';

class SCAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SCAppBar({
    super.key,
    this.menuIconVisible = true,
  });

  final bool menuIconVisible;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Image(
        image: AssetImage('assets/images/logo_230x76.png'),
        width: 230,
        height: 76,
      ),
      automaticallyImplyLeading: false,
      actions: menuIconVisible ? [
        IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu),
        )
      ] : [],
    );
  }
}