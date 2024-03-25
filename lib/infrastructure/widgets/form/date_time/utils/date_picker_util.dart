import 'package:flutter/material.dart';

class DatePickerParams {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? currentDate;
  final DatePickerMode initialDatePickerMode;
  final Color selectedDateColor;
  final Color onSelectedDateColor;
  final TextStyle headerTextStyle;
  final String? confirmText;
  final String? cancelText;
  final Color dialogBackgroundColor;
  final Color headerColor;
  final Color onHeaderColor;
  final TextStyle dayTextStyle;

  DatePickerParams({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.currentDate,
    required this.initialDatePickerMode,
    this.selectedDateColor = const Color(0xff2BE2BF),
    this.onSelectedDateColor = Colors.white,
    this.headerTextStyle = const TextStyle(
      color: Color(0xff262626),
    ),
    this.confirmText,
    this.cancelText,
    this.dialogBackgroundColor = Colors.white,
    this.headerColor = Colors.white,
    this.onHeaderColor = Colors.black,
    this.dayTextStyle = const TextStyle(
      color: Color(0xff262626),
    ),
  });
}

Future<DateTime?> pickDate(BuildContext context,DatePickerParams params) {
  return showDatePicker(
    currentDate: params.currentDate,
    context: context,
    initialDate: params.initialDate,
    firstDate: params.firstDate,
    lastDate: params.lastDate,
    confirmText: params.confirmText,
    cancelText: params.cancelText,
    initialDatePickerMode: params.initialDatePickerMode,
    fieldLabelText: 'Tanggal',
    fieldHintText: 'Pilih Tanggal',
    helpText: '',
    builder: (context, child) => Theme(
      data: ThemeData(
        textTheme: TextTheme(
          titleMedium: params.headerTextStyle,
          titleSmall: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          bodySmall: params.dayTextStyle,
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: params.selectedDateColor,
          onPrimary: params.onSelectedDateColor,
          surface: params.headerColor,
          onSurface: params.onHeaderColor,
        ),
        dialogBackgroundColor: params.dialogBackgroundColor,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
          ),
        ),
      ),
      child: child!,
    ),
  );
}
