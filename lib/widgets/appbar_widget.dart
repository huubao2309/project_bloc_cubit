import 'package:flutter/material.dart';

class AppBarStandard extends StatefulWidget implements PreferredSizeWidget {
  const AppBarStandard({
    super.key,
    required this.title,
    this.onBack,
    this.actions = const <Widget>[],
    this.isVisibleBackButton = true,
  });

  final String title;
  final bool isVisibleBackButton;
  final List<Widget> actions;
  final VoidCallback? onBack;

  @override
  State<AppBarStandard> createState() => _AppBarStandardState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _AppBarStandardState extends State<AppBarStandard> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: widget.isVisibleBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: widget.onBack,
            )
          : null,
      actions: widget.actions,
    );
  }
}
