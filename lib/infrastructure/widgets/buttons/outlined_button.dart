import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/base_button.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/button_icon_type.dart';

class CBOutlinedButton extends StatelessWidget {
  final String label;
  final bool fillParent;
  final VoidCallback? onPressed;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? outlinedColor;
  final ButtonIconType buttonIconType;
  final bool keepBalance;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  const CBOutlinedButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.padding = const EdgeInsets.all(12),
      this.fillParent = false,
      this.prefixIcon,
      this.buttonIconType = ButtonIconType.far,
      this.outlinedColor,
      this.keepBalance = false,
      this.suffixIcon,
      this.textStyle});

  Widget buildButton(BuildContext context) {
    final style = Theme.of(context).outlinedButtonTheme.style ?? OutlinedButton.styleFrom();

    return OutlinedButton(
        onPressed: onPressed,
        style: style.copyWith(
            side: MaterialStatePropertyAll(BorderSide(color: outlinedColor ?? context.color.primary, width: 1.25)),
            textStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 18)),
            padding: MaterialStateProperty.all(padding),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)))),
        child: CBButtonContent(
            fillParent: fillParent,
            buttonIconType: buttonIconType,
            prefixIcon: prefixIcon,
            keepBalance: keepBalance,
            suffixIcon: suffixIcon,
            label: label,
            textStyle: textStyle));
  }

  @override
  Widget build(BuildContext context) {
    final button = buildButton(context);
    return fillParent
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }
}
