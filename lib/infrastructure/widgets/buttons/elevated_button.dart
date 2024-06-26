import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/base_button.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/button_icon_type.dart';

class MGElevatedButton extends StatelessWidget {
  final String label;
  final bool fillParent;
  final VoidCallback? onPressed;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ButtonIconType buttonIconType;
  final bool keepBalance;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final double elevation;
  const MGElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.fillParent = false,
    this.elevation = 2,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.buttonIconType = ButtonIconType.far,
    this.keepBalance = false,
    this.textStyle,
    this.padding = const EdgeInsets.all(12),
    this.foregroundColor,
  });

  Widget buildButton(BuildContext context) {
    final style = Theme.of(context).elevatedButtonTheme.style ?? ElevatedButton.styleFrom();

    return ElevatedButton(
        onPressed: onPressed,
        style: style.copyWith(
            elevation: MaterialStateProperty.all(elevation),
            foregroundColor: MaterialStatePropertyAll(foregroundColor ?? context.color.onPrimary),
            backgroundColor: MaterialStatePropertyAll(backgroundColor ?? context.color.onSurface),
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
          textStyle: textStyle,
        ));
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
