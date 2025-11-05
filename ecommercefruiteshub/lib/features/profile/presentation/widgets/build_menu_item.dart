import 'package:flutter/material.dart';

class BuildMenuItem extends StatelessWidget {
  const BuildMenuItem({
    super.key,
    required this.leadingWidget,
    required this.traillingWidget,
    required this.title,
    required this.onTap,
  });
  final Widget leadingWidget;
  final Widget traillingWidget;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingWidget,
      title: Text(title),
      trailing: traillingWidget,
      onTap: onTap,
    );
  }
}
