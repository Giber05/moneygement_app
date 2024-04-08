import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/messenger/messenger_cubit.dart';
import 'package:moneygement_app/infrastructure/ext/color_ext.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/routing/router.gr.dart';
import 'package:moneygement_app/modules/overview/presentation/tabs/spending/spending_overview_tab.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          context.read<MessengerCubit>().showSuccessSnackbar('message');
          break;
        case 1:
          context.read<MessengerCubit>().showSuccessSnackbar('sadsad');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: context.color.background,
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          key: _key,
          type: ExpandableFabType.up,
          distance: 75,
          overlayStyle: ExpandableFabOverlayStyle(
            color: Colors.black.withOpacity(.4),
          ),
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.add),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: context.color.background,
            backgroundColor: context.color.onSurface,
            shape: const CircleBorder(),
          ),
          closeButtonBuilder: DefaultFloatingActionButtonBuilder(
            child: const Icon(Icons.close),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: context.color.background,
            backgroundColor: context.color.onSurface,
            shape: const CircleBorder(),
          ),
          children: [
            FloatingActionButton.extended(
              backgroundColor: context.color.onSurface,
              heroTag: null,
              label: const SizedBox(
                width: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pemasukan',
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_circle_down),
                  ],
                ),
              ),
              onPressed: () {
                final state = _key.currentState;
                if (state != null && state.isOpen) {
                  state.toggle();
                  context.router.push(const CreateIncomeRoute());
                }
              },
            ),
            FloatingActionButton.extended(
              backgroundColor: context.color.onSurface,
              heroTag: null,
              label: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pengeluaran',
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_circle_up),
                ],
              ),
              onPressed: () {
                final state = _key.currentState;
                if (state != null && state.isOpen) {
                  state.toggle();
                }
              },
            ),
          ],
        ),
        appBar: AppBar(
          title: const Center(child: Text('Overview')),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: context.color.primaryToSecondaryGradient,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height * 1.2),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.grey[200],
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(32), gradient: context.color.secondaryTotertieryGradient),
                  tabs: const [Tab(text: 'Spending'), Tab(text: 'List')],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            SpendingOverview(),
            Center(
              child: Text(
                'Advanced Settings',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
