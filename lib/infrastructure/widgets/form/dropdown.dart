import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:sizer/sizer.dart';

class AddNewItemUtil {
  final String title;
  final VoidCallback onTap;

  AddNewItemUtil({required this.title, required this.onTap});
}

class MGDropdown<T> extends StatefulWidget {
  final List<(String label, T data)> choices;
  final T? initialValue;
  final MGDropdownController? controller;
  final String label;
  final String? hintText;
  final String? desc;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(T?)? validator;
  final TextInputType? inputType;
  final int minLine;
  final int maxLine;
  final bool readOnly;
  final bool filled;
  final Color? backgroundColor;
  final Function(String value)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final EdgeInsets? contentPadding;
  final bool? enabled;
  final FocusNode? focusNode;
  final bool? autofocus;
  final BorderRadius borderRadius;
  final AddNewItemUtil? hasAddNewItemUtil;
  MGDropdown({
    super.key,
    required this.choices,
    this.controller,
    this.hintText,
    this.focusNode,
    this.minLine = 1,
    this.autofocus,
    this.maxLine = 1,
    this.label = '',
    this.enabled,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.prefixIcon,
    this.inputType,
    this.desc,
    this.readOnly = false,
    this.backgroundColor,
    this.filled = false,
    this.onFieldSubmitted,
    this.textInputAction,
    this.contentPadding,
    this.initialValue,
    this.hasAddNewItemUtil,
  }) : borderRadius = BorderRadius.circular(8);

  @override
  State<MGDropdown<T>> createState() => _MGDropdownState<T>();
}

class MGDropdownController<T> {
  _MGDropdownState<T>? _state;
  MGDropdownController();

  _init(_MGDropdownState<T>? state) {
    _state = state;
  }

  dispose() {
    _state = null;
  }

  T? get value => _state?._value;
}

class _MGDropdownState<T> extends State<MGDropdown<T>> {
  T? _value;
  List<DropdownMenuItem<T>> optionItems = [];
  @override
  void initState() {
    super.initState();
    widget.controller?._init(this);
    _value = widget.initialValue;
    final hasAddNewItemUtil = widget.hasAddNewItemUtil;
    if (hasAddNewItemUtil != null) {
      optionItems.add(
        DropdownMenuItem(
          value: _value,
          onTap: () {
            print('ontap');
            hasAddNewItemUtil.onTap.call();
          },
          enabled: true,
          child: Text(
            hasAddNewItemUtil.title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    widget.choices.map(
      (choice) => optionItems.add(
        DropdownMenuItem(
          value: choice.$2,
          child: Text(
            choice.$1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return DropdownButtonFormField<T>(
        items: optionItems,
        isExpanded: true,
        value: _value,
        validator: widget.validator,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          labelText: widget.label,
          suffixIconColor: context.color.outline,
          errorStyle: context.text.bodySmall?.copyWith(color: color.error, fontSize: 10.sp),
          labelStyle: text.bodySmall,
          alignLabelWithHint: false,
          errorMaxLines: 3,
          errorBorder:
              OutlineInputBorder(borderRadius: widget.borderRadius, borderSide: BorderSide(color: color.error)),
          focusedErrorBorder:
              OutlineInputBorder(borderRadius: widget.borderRadius, borderSide: BorderSide(color: color.error)),
          focusedBorder:
              OutlineInputBorder(borderRadius: widget.borderRadius, borderSide: BorderSide(color: color.primary)),
          enabledBorder:
              OutlineInputBorder(borderRadius: widget.borderRadius, borderSide: BorderSide(color: color.outline)),
          hintText: widget.hintText,
          contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        ),
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        });
  }
}
