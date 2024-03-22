// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/ext/shadow_ext.dart';
import 'package:moneygement_app/modules/overview/presentation/tabs/spending/chart_examples/bar_chart_example.dart';
import 'package:moneygement_app/modules/overview/presentation/widgets/month_picker.dart';

import 'package:moneygement_app/infrastructure/ext/double_ext.dart';

class SpendingOverview extends StatelessWidget {
  const SpendingOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            16.verticalSpace,
            MonthPicker(
              subTitle: '11 Transaksi',
              onMonthChanged: (date) {},
            ),
            16.verticalSpace,
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadowExtension.light()],
                ),
                child: BarChartSample2()),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadowExtension.light()],
                ),
                child: BarChartSample2()),
          ],
        ),
      ),
    );
  }
}
