import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';

class BottomSheetAction {
  final String text;
  final VoidCallback onTap;

  const BottomSheetAction({
    required this.text,
    required this.onTap,
  });
}

void openBottomSheet({required BuildContext context, List<BottomSheetAction> actions = const []}) async {
  final color = context.color;
  final text = context.text;

  await showModalBottomSheet(
    context: context,
    
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8),
      ),
    ),
    builder: (context) => Material(
      color: color.onPrimary,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 24,
              width: 24,
              margin: const EdgeInsets.only(
                left: 12,
                top: 16,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                onPressed: () => context.router.maybePop(),
              ),
            ),
            for (final action in actions) ...[
              InkWell(
                onTap: action.onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        action.text,
                        style: text.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],
        ),
      ),
    ),
  );
}
