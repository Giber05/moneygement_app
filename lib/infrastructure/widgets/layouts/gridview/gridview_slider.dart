import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';

// ignore: must_be_immutable
class GridViewSlider<T> extends StatelessWidget {
  final List<T> items;
  final int countPerPage;
  final Function(T selectedItem)? onSelect;
  Widget Function(T item) itemBuilder;
  GridViewSlider({
    Key? key,
    required this.items,
    required this.countPerPage,
    this.onSelect,
    required this.itemBuilder,
  }) : super(key: key);

  ValueNotifier<int> currentIndex = ValueNotifier(0);

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    int pageCount = (items.length / countPerPage).ceil();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              currentIndex.value = index;
            },
          ),
          items: List.generate(pageCount, (index) {
            final totalItem = items.length;
            final endItemIndex = ((index + 1) * countPerPage) < totalItem ? ((index + 1) * countPerPage) : totalItem;
            final startItemIndex = index * countPerPage < totalItem ? index * countPerPage : totalItem;

            return buildGridPage(items.sublist(startItemIndex, endItemIndex), Key('$index'));
          }),
        ),
        16.verticalSpace,
        ValueListenableBuilder(
            valueListenable: currentIndex,
            builder: (context, currentPage, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pageCount, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: currentPage == index ? 12.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == index ? Colors.black : Colors.grey,
                    ),
                  );
                }),
              );
            }),
        20.verticalSpace,
      ],
    );
  }

  Widget buildGridPage(List<T> items, Key? key) {
    return GridView.builder(
      key: key,
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Material(
          color: context.color.background,
          elevation: 2,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              print('Index: $index');
              onSelect?.call(item);
            },
            child: itemBuilder(item),
          ),
        );
      },
    );
  }
}
