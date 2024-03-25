import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/widgets/form/date_time/utils/date_range_util.dart';
import 'package:sizer/sizer.dart';

class MGDateRangePicker extends StatefulWidget {
  final DateTimeRange? initialDateTimeRange;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? confirmText;
  final String? cancelText;
  final String? saveText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final FormFieldSetter<DateTimeRange>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final bool isFilled;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool enabled;
  final EdgeInsets? contentPadding;
  final BorderRadius borderRadius;

  const MGDateRangePicker({
    Key? key,
    this.initialDateTimeRange,
    this.firstDate,
    this.lastDate,
    this.confirmText,
    this.cancelText,
    this.saveText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.onFieldSubmitted,
    this.validator,
    this.isFilled = true,
    this.labelStyle,
    this.style,
    this.hintStyle,
    this.enabled = true,
    this.contentPadding,
    required this.borderRadius,
  }) : super(key: key);

  @override
  MGDateRangePickerState createState() => MGDateRangePickerState();
}

class MGDateRangePickerState extends State<MGDateRangePicker> {
  DateTimeRange? _selectedDateRange;
  final _dateFormat = DateFormat('dd/MM/yyyy');
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
    final initialValue = widget.initialDateTimeRange;
    if (initialValue != null) {
      _textEditingController.value =
          TextEditingValue(text: '${_dateFormat.format(initialValue.start)} - ${_dateFormat.format(initialValue.end)}');
    }
    _selectedDateRange = initialValue;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          focusNode: _focusNode,
          enabled: widget.enabled,
          controller: _textEditingController,
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
                borderRadius: widget.borderRadius, borderSide: BorderSide(color: context.color.surfaceTint)),
            focusedBorder: OutlineInputBorder(
                borderRadius: widget.borderRadius, borderSide: BorderSide(color: context.color.primary)),
            errorBorder: OutlineInputBorder(
                borderRadius: widget.borderRadius, borderSide: BorderSide(color: context.color.error)),
          ),
          onFieldSubmitted: (newValue) {
            if (_selectedDateRange != null) {
              widget.onFieldSubmitted?.call(_selectedDateRange!);
            } else {
              widget.onFieldSubmitted?.call(null);
            }
          },
          onTap: () async {
            final dateRangeParams = DateRangeParams(
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              initialValue: _selectedDateRange,
              cancelText: widget.cancelText,
              confirmText: widget.confirmText,
              saveText: widget.saveText,
            );
            final pickedDate = await pickDateRange(context, dateRangeParams);

            if (pickedDate != null && pickedDate != _selectedDateRange) {
              setState(() {
                _selectedDateRange = pickedDate;
              });
              _textEditingController.text =
                  '${_dateFormat.format(pickedDate.start)} - ${_dateFormat.format(pickedDate.end)}';
            }
          },
        ),
      ],
    );
  }
}
