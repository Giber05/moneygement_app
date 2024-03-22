import 'package:flutter/cupertino.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';

class CBCircularLoading extends StatelessWidget {
  final Color? color;
  final double? radius;
  const CBCircularLoading({super.key, this.color, this.radius});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: radius ?? 20,
      color: color ?? context.color.primary,
    );
  }
}
