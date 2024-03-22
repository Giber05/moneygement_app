import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';
import 'package:moneygement_app/infrastructure/gen/assets.gen.dart';
import 'package:moneygement_app/infrastructure/routing/router.gr.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/outlined_button.dart';
import 'package:moneygement_app/infrastructure/widgets/layouts/dialog/dialog_container.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/circular.dart';
import 'package:flutter/material.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:moneygement_app/modules/authentication/presentation/widgets/logged_in_wrapper.dart';
import 'package:moneygement_app/modules/overview/presentation/overview_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthenticatedWrapper(child: _HomeScreenContent());
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> currentBotNavIndex = ValueNotifier(0);
    return Scaffold(
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: currentBotNavIndex,
            builder: (context, currentIndex, _) {
              return SalomonBottomBar(
                currentIndex: currentIndex,
                onTap: (i) => currentBotNavIndex.value = i,
                items: [
                  /// Home
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.home),
                    title: const Text("Overview"),
                    selectedColor: context.color.onSurface,
                  ),

                  /// Likes
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.attach_money),
                    title: const Text("Budget"),
                    selectedColor: context.color.error,
                  ),

                  SalomonBottomBarItem(
                    icon: Icon(Icons.person),
                    title: Text("Profile"),
                    selectedColor: Colors.teal,
                  ),
                ],
              );
            }),
        body: ValueListenableBuilder(
            valueListenable: currentBotNavIndex,
            builder: (context, currentIndex, _) => [
                  OverviewScreen(),
                  Center(
                    child: Text('Budget'),
                  ),
                  Center(
                    child: Text('Profile'),
                  ),
                ][currentIndex]));
  }
}
