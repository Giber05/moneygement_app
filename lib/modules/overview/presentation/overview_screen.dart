import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/messenger/messenger_cubit.dart';
import 'package:moneygement_app/infrastructure/ext/color_ext.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/modules/overview/presentation/tabs/spending/spending_overview_tab.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
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
          children: [
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
