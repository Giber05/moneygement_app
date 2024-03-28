import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:sizer/sizer.dart';

part 'utils/date_picker_util.dart';

class MGDatePicker extends StatefulWidget {
  final bool enabled;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final DatePickerMode initialDatePickerMode;
  final String? confirmText;
  final String? cancelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final FormFieldSetter<DateTime>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final bool isFilled;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final BorderRadius? borderRadius;

  const MGDatePicker({
    Key? key,
    this.enabled = true,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.hintText,
    this.initialDatePickerMode = DatePickerMode.day,
    this.confirmText,
    this.cancelText,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.onFieldSubmitted,
    this.validator,
    this.isFilled = true,
    this.labelStyle,
    this.style,
    this.hintStyle,
    this.contentPadding,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<MGDatePicker> createState() => MGnDatePickerState();
}

class MGnDatePickerState extends State<MGDatePicker> {
  DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  bool _isFocus = false;
  bool _isError = false;
  Color getFillColor(BuildContext ctx) {
    if (widget.isFilled || _isFocus || _isError) {
      return context.color.onPrimary;
    }
    return context.color.surfaceTint;
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });
    final initialValue = widget.initialDate;
    if (initialValue != null) {
      _textEditingController.value = TextEditingValue(text: _dateFormat.format(initialValue));
    }
    _selectedDate = initialValue;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      enabled: widget.enabled,
      controller: _textEditingController,
      onFieldSubmitted: (newValue) {
        if (_selectedDate != null) {
          widget.onFieldSubmitted?.call(_selectedDate);
        } else {
          widget.onFieldSubmitted?.call(null);
        }
      },
      onTap: () async {
        print('Tap Date Field');
        final datePickerParams = DatePickerParams(
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime(1900),
          lastDate: widget.lastDate ?? DateTime(3000),
          currentDate: widget.initialDate ?? DateTime.now(),
          initialDatePickerMode: widget.initialDatePickerMode,
          confirmText: widget.confirmText,
          cancelText: widget.cancelText,
        );
        final pickedDate = await pickDate(context, datePickerParams);
        if (pickedDate != null && pickedDate != _selectedDate) {
          setState(() {
            _selectedDate = pickedDate;
          });
          _textEditingController.text = _dateFormat.format(pickedDate);
        }
      },
      readOnly: true,
      validator: (value) {
        final error = widget.validator?.call(value);
        setState(() {
          _isError = error != null;
        });
        return error;
      },
      style: widget.style ?? context.text.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        labelText: widget.label,
        suffixIconColor: context.color.outline,
        labelStyle: context.text.bodySmall,
        filled: true,
        fillColor: widget.enabled ? getFillColor(context) : context.color.surfaceTint,
        isDense: true,
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        errorStyle: context.text.bodySmall?.copyWith(color: context.color.error, fontSize: 10.sp),
        enabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            borderSide: BorderSide(color: context.color.surfaceTint)),
        focusedBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            borderSide: BorderSide(color: context.color.primary)),
        errorBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            borderSide: BorderSide(color: context.color.error)),
      ),
    );
  }
}
