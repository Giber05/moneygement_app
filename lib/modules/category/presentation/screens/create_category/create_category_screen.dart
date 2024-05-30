// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/widgets/layouts/appbar/mg_appbar.dart';
import 'package:moneygement_app/infrastructure/widgets/layouts/gridview/gridview_slider.dart';

import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';
import 'package:moneygement_app/infrastructure/gen/assets.gen.dart';

@RoutePage()
class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MGAppbar(
              title: 'Buat Kategori Baru',
            ),
            20.verticalSpace,
            Text('Pilih Icon', style: context.text.labelLarge),
            Container(
              decoration: BoxDecoration(
                color: context.color.outline,
                borderRadius: BorderRadius.circular(12),
              ),
              child: GridViewSlider<AssetGenImage>(
                  items: Assets.icons.category.values,
                  countPerPage: 15,
                  onSelect: (value) {
                    print('current item: ${value.path}');
                  },
                  itemBuilder: (item) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: item.image(width: 20, height: 20),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
