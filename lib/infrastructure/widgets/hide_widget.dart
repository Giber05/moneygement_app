import 'package:flutter/material.dart';

class CBHideWidget extends StatelessWidget {
  final Widget child;
  final bool visible;
  const CBHideWidget({super.key, required this.child, required this.visible});

  @override
  Widget build(BuildContext context) {
    return Visibility(maintainAnimation: true, maintainSize: true, visible: visible, maintainState: true, child: child);
  }
}
