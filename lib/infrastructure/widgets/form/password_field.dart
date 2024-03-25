import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/utils/value_validator/form_validator.dart';
import 'package:moneygement_app/infrastructure/widgets/form/text_field.dart';

class CBPasswordField extends StatefulWidget {
  final ValueValidator<String?> validator;
  final String label;
  final TextEditingController controller;
  const CBPasswordField({super.key, required this.validator, required this.label, required this.controller});

  @override
  State<CBPasswordField> createState() => _CBPasswordFieldState();
}

class _CBPasswordFieldState extends State<CBPasswordField> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return MGTextField(
      obscureText: _isPasswordHidden,
      suffixIcon: InkWell(
        onTap: () => setState(() {
          _isPasswordHidden = !_isPasswordHidden;
        }),
        child: Icon(
          _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
        ),
      ),
      validator: widget.validator,
      controller: widget.controller,
      label: widget.label,
    );
  }
}
