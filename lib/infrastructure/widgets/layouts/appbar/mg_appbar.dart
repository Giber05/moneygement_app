import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';
import 'package:moneygement_app/infrastructure/ext/shadow_ext.dart';

class MGAppbar extends StatelessWidget {
  const MGAppbar({
    Key? key,
    this.onBack,
    required this.title,
    this.actions,
  }) : super(key: key);
  final VoidCallback? onBack;
  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              context.router.maybePop();
              onBack?.call();
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.color.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.color.outline),
                boxShadow: [BoxShadowExtension.light()],
              ),
              child: Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: context.color.onBackground,
              ),
            ),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  maxLines: 1,
                  style: context.text.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (actions != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                )
            ],
          ),
        ],
      ),
    );
  }
}