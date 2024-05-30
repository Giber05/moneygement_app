// ignore_for_file: must_be_immutable

part of '../create_income.dart';

class _CreateIncomeForm extends StatelessWidget {
  const _CreateIncomeForm({
    required this.categories,
  });
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    final bloc = context.read<IncomeTransactionBloc>();
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
          key: bloc.formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    color: context.color.onPrimary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadowExtension.medium()]),
                child: Column(
                  children: [
                    20.verticalSpace,
                    TextFormField(
                      controller: bloc.amountFieldController,
                      validator: (value) {
                        print('Value amount: $value');
                        if (value == null || value.isEmpty) {
                          return 'Masukan nominal transaksi';
                        }
                        return null;
                      },
                      style: context.text.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold, color: context.color.onSurface),
                      textAlign: TextAlign.center,
                      inputFormatters: <TextInputFormatter>[
                        CurrencyTextInputFormatter(
                          locale: 'id',
                          symbol: 'Rp. ',
                          decimalDigits: 0,
                        ),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Rp.0', enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
                    ),
                    16.verticalSpace,
                    ValueListenableBuilder(
                      valueListenable: bloc.selectedCategory,
                      builder: (context, category, _) {
                        return CustomDropdown<CategoryModel>.search(
                          items: categories,
                          initialItem: category,
                          listItemPadding: EdgeInsets.zero,
                          hintText: 'Pilih Kategori',
                          onChanged: (value) {
                            if (value.id == 0) {
                              bloc.selectedCategory.value = null;
                            } else {
                              bloc.selectedCategory.value = value;
                            }
                          },
                          listItemBuilder: (context, item, isSelected, onItemSelected) {
                            if (item.id == 0) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () async {
                                    context.router.push(const CreateCategoryRoute());
                                    // await showDialog(
                                    //   context: context,
                                    //   builder: (context) => CreateNewCategoryDialog(),
                                    // );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Icon(Icons.add),
                                      4.horizontalSpace,
                                      const Text('Tambah Kategori Baru'),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.name),
                            );
                          },
                          headerBuilder: (context, selectedItem) => Text(selectedItem.name),
                          excludeSelected: false,
                          decoration: CustomDropdownDecoration(
                            closedBorder: Border.all(),
                          ),
                          validator: (item) {
                            if (item == null || item.id == 0) {
                              return 'Pilih salah satu kategori';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    16.verticalSpace,
                    MGDatePicker(
                      onChanged: (DateTime? newValue) {
                        if (newValue != null) {
                          print('Date Picked');
                          bloc.selectedTransactionDate.value = newValue;
                        }
                      },
                      borderRadius: null,
                      enabled: true,
                      label: 'Tanggal & Waktu',
                      hintText: 'Pilih tanggal transaksi',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih waktu transaksi';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    MGTextField(
                      label: 'Catatan',
                      controller: bloc.noteFieldCntroller,
                    )
                  ],
                ),
              ),
              20.verticalSpace,
              MGElevatedButton(
                label: 'Simpan',
                elevation: 2,
                fillParent: true,
                onPressed: () {
                  bloc.add(CreateIncomeEvent(
                    categories: categories,
                    type: 'INCOME',
                    userId: context.userSession.user.userId,
                  ));
                },
              ),
            ],
          )),
    );
  }
}

class CreateNewCategoryDialog extends StatefulWidget {
  const CreateNewCategoryDialog({
    super.key,
  });

  @override
  State<CreateNewCategoryDialog> createState() => _CreateNewCategoryDialogState();
}

class _CreateNewCategoryDialogState extends State<CreateNewCategoryDialog> {
  Icon? _icon;
  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      maxHeightPercentage: .6,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Text('Buat Kategori Baru', style: context.text.titleLarge),
              ),
              16.verticalSpace,
              MGTextField(
                label: 'Nama Kategori',
                validator: (value) => value == null ? 'Masukan nama kategori' : null,
              ),
              16.verticalSpace,
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: Colors.grey[300]),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _icon ?? const SizedBox(),
                    ),
                  ),
                  8.horizontalSpace,
                  MGElevatedButton(
                    fillParent: false,
                    label: 'Pilih Icon',
                    onPressed: () async {
                      IconData? icon = await showIconPicker(context, iconPackModes: [
                        IconPack.cupertino,
                        IconPack.allMaterial,
                      ]);

                      _icon = Icon(
                        icon,
                      );
                      setState(() {});

                      debugPrint('Picked Icon:  $icon');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
