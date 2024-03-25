// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TimePickerParams {
  final TimeOfDay initialTime;
  final TimePickerEntryMode initialEntryMode;
  final Color primaryColor;
  final Color onPrimaryColor;
  final String? confirmText;
  final String? cancelText;
  final Color backgroundColor;
  final String? helpText;
  final String? errorInvalidText;
  final String? hourLabelText;
  final String? minuteLabelText;
  final bool alwaysUse24HourFormat;
  void Function(TimePickerEntryMode)? onEntryModeChanged;

  TimePickerParams({
    required this.initialTime,
    this.initialEntryMode = TimePickerEntryMode.dial,
    this.primaryColor = const Color(0xff2BE2BF),
    this.onPrimaryColor = Colors.white,
    this.confirmText,
    this.cancelText,
    this.backgroundColor = Colors.white,
    this.helpText = '',
    this.errorInvalidText = 'Masukan Format Waktu yang Valid!',
    this.hourLabelText = 'Jam',
    this.minuteLabelText = 'Menit',
    this.alwaysUse24HourFormat = false,
    this.onEntryModeChanged,
  });
}

Future<TimeOfDay?> pickTime(BuildContext context, TimePickerParams params) {
  return showTimePicker(
    initialTime: params.initialTime,
    onEntryModeChanged: params.onEntryModeChanged,
    context: context,
    confirmText: params.confirmText,
    cancelText: params.cancelText,
    helpText: params.helpText,
    errorInvalidText: params.errorInvalidText,
    hourLabelText: params.hourLabelText,
    initialEntryMode: params.initialEntryMode,
    minuteLabelText: params.minuteLabelText,
    builder: (context, child) => Theme(
      data: ThemeData(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: params.backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          hourMinuteShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          dayPeriodShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          dayPeriodBorderSide: BorderSide.none,
          dayPeriodColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? params.primaryColor
                : Colors.grey.shade300,
          ),
          dayPeriodTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? params.onPrimaryColor
                : Colors.black,
          ),
          hourMinuteColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? params.primaryColor
                : Colors.grey.shade300,
          ),
          hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? params.onPrimaryColor
                  : Colors.black),
          dialHandColor: params.primaryColor,
          entryModeIconColor: params.primaryColor,
          dialBackgroundColor: params.onPrimaryColor,
          dialTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? params.onPrimaryColor
                : Colors.black,
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: params.primaryColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => params.onPrimaryColor),
            foregroundColor:
                MaterialStateColor.resolveWith((states) => params.primaryColor),
          ),
        ),
      ),
      child: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(alwaysUse24HourFormat: params.alwaysUse24HourFormat),
        child: child!,
      ),
    ),
  );
}
