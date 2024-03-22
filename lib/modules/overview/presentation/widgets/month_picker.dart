import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/ext/shadow_ext.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:moneygement_app/infrastructure/ext/date_ext.dart';

class MonthPicker extends StatefulWidget {
  const MonthPicker({
    Key? key,
    required this.subTitle,
    this.currentDate,
    required this.onMonthChanged,
  }) : super(key: key);

  final String subTitle;
  final DateTime? currentDate;
  final Function(DateTime month) onMonthChanged;

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  late ValueNotifier<DateTime?> selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.currentDate != null
        ? ValueNotifier<DateTime?>(widget.currentDate)
        : ValueNotifier<DateTime?>(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadowExtension.light(),
        ],
      ),
      child: Row(
        children: [
          MaterialButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            onPressed: () {
              final newDate = DateTime(selectedMonth.value!.year, selectedMonth.value!.month - 1);

              selectedMonth.value = newDate;
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          ValueListenableBuilder(
              valueListenable: selectedMonth,
              builder: (context, currentSelectedMonth, _) {
                return Expanded(
                    child: InkWell(
                  onTap: () async {
                    final pickedMonth = await showMonthPicker(
                        backgroundColor: context.color.background,
                        headerColor: context.color.onSurface,
                        selectedMonthBackgroundColor: context.color.secondary,
                        context: context,
                        roundedCornersRadius: 16);
                    if (pickedMonth != null) {
                      selectedMonth.value = pickedMonth;
                      widget.onMonthChanged(pickedMonth);
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${currentSelectedMonth?.dateStringForm(pattern: 'MMMM yyyy')}",
                        style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '11 Transaksi',
                        style: context.text.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ));
              }),
          MaterialButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            onPressed: () {
              final newDate = DateTime(selectedMonth.value!.year, selectedMonth.value!.month + 1);

              selectedMonth.value = newDate;
            },
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
