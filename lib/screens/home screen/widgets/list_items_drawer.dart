
import 'package:flutter/material.dart';

class ListItemsDrawer extends StatelessWidget {
  const ListItemsDrawer({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Icon(icon),
      title: Text(text),
    );
  }
}