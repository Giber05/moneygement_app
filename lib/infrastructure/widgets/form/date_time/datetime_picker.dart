import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/widgets/form/date_time/date_picker.dart';
import 'package:moneygement_app/infrastructure/widgets/form/date_time/utils/time_picker_util.dart';
import 'package:sizer/sizer.dart';

class MGDateTimePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DatePickerMode initialDatePickerMode;
  final TimeOfDay? initialTime;
  final TimePickerEntryMode? initialEntryMode;
  final String? confirmText;
  final String? cancelText;
  final bool? alwaysUse24HourFormat;
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
  final BorderRadius borderRadius;
  final bool enabled;


  const MGDateTimePicker({
    Key? key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.initialTime,
    this.initialEntryMode,
    this.confirmText,
    this.cancelText,
    this.alwaysUse24HourFormat,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.onFieldSubmitted,
    this.validator,
    required this.isFilled,
    this.labelStyle,
    this.style,
    this.hintStyle,
    this.contentPadding,
    required this.borderRadius, required this.enabled,
  }) : super(key: key);

  @override
  State<MGDateTimePicker> createState() => _MGDateTimePickerState();
}

class _MGDateTimePickerState extends State<MGDateTimePicker> {
  DateTime? _selectedDateTime;
  final _dateFormat = DateFormat('dd/MM/yyyy hh:mm');
  late DatePickerParams _datePickerParams;
  late TimePickerParams _timePickerParams;
  late TextEditingController _textEditingController;
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
    final initialDateValue = widget.initialDate;
    final initialTimeValue = widget.initialTime;
    DateTime initialValue;
    if (initialDateValue != null && initialTimeValue != null) {
      initialValue = DateTime(
        initialDateValue.year,
        initialDateValue.month,
        initialDateValue.day,
        initialTimeValue.hour,
        initialTimeValue.minute,
      );
      _textEditingController = TextEditingController(text: _dateFormat.format(initialValue));
      _selectedDateTime = initialValue;
    } else {
      _textEditingController = TextEditingController(text: 'Select Date and Time');
    }
  }

  @override
  void dispose() {
    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });
    final initialValue = widget.initialDate;
    if (initialValue != null) {
      _textEditingController.value = TextEditingValue(text: _dateFormat.format(initialValue));
    }
    _selectedDateTime = initialValue;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('RknDateTimePickerTextField'),
      controller: _textEditingController,
      readOnly: true,
      onTap: () async {
        _datePickerParams = DatePickerParams(
          initialDate: _selectedDateTime ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime(1900),
          lastDate: widget.lastDate ?? DateTime(2100),
          currentDate: widget.initialDate ?? DateTime.now(),
          initialDatePickerMode: widget.initialDatePickerMode,
          confirmText: widget.confirmText,
          cancelText: widget.cancelText,
        );
        final pickedDate = await pickDate(context, _datePickerParams);
        if (pickedDate == null) {
          return;
        } else {
          _timePickerParams = TimePickerParams(
            initialTime: _selectedDateTime != null
                ? TimeOfDay(
                    hour: _selectedDateTime!.hour,
                    minute: _selectedDateTime!.minute,
                  )
                : TimeOfDay.now(),
            alwaysUse24HourFormat: widget.alwaysUse24HourFormat ?? false,
            initialEntryMode: widget.initialEntryMode ?? TimePickerEntryMode.dial,
            cancelText: widget.cancelText,
            confirmText: widget.confirmText,
          );
          // ignore: use_build_context_synchronously
          final pickedTime = await pickTime(context, _timePickerParams);
          if (pickedTime == null) {
            return;
          } else {
            final dateTimeResult =
                DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
            setState(() {
              _selectedDateTime = dateTimeResult;
            });
            _textEditingController.text = _dateFormat.format(dateTimeResult);
          }
        }
      },
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
        focusedBorder:
            OutlineInputBorder(borderRadius: widget.borderRadius, borderSide: BorderSide(color: context.color.primary)),
        errorBorder:
            OutlineInputBorder(borderRadius: widget.borderRadius, borderSide: BorderSide(color: context.color.error)),
      ),
    );
  }
}
