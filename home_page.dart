import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarpl/core/constants/menu_id_constants.dart';
import 'package:sarpl/features/customer_loan_info/presentation/cubit/customer_loan_info_cubit.dart';
import 'package:sarpl/features/customer_loan_info/presentation/cubit/customer_loan_info_state.dart';

import '../core/core.dart';
import 'customer_loan_info/domain/entities/get_menu_details_entity.dart';

class HomePage extends StatefulWidget {
  final RoutingHelper routingHelper;
  const HomePage({super.key, required this.routingHelper});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<GetMenuDetailsResultEntity> result = [];

  @override
  void initState() {
    result = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: SARPLColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppBar(
          titleText: "Home",
          hideBackBtn: true,
          onBack: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: BlocConsumer<CustomerLoanInfoCubit, CustomerLoanInfoState>(
        listener: (context, state) {
          /*  if (state is GetMenuDetailsLoadingState) {
            UtilsMethods()
                .showSaveGifProgressBar(context, StringConstants.kLoading);
          } else */
          if (state is GetMenuDetailsLoadedState) {
            widget.routingHelper.goBack();
            result = state.entity.getMenuDetailsResult;
          } else if (state is GetMenuDetailsErrorState) {
            widget.routingHelper.goBack();
            UtilsMethods.callSnackbar(context, state.failure.message);
          }
        },
        builder: (context, state) {
          return const Center(
            child: Text(""),
          );
        },
      ),
      drawer: BlocConsumer<CustomerLoanInfoCubit, CustomerLoanInfoState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Drawer(
            backgroundColor: SARPLColors.white,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    "Raja a",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  accountEmail: Text(
                    "nilesh@gmail.com",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      "RAJA A",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                if (result.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      itemCount: result[0].menuInfoL.length,
                      itemBuilder: (context, index) {
                        final data = result[0].menuInfoL[index];
                        return ListTile(
                          title: Text(
                            data.menuName,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: const Icon(Icons.new_releases),
                          onTap: () {
                            widget.routingHelper.goBack();
                            if (data.menuID ==
                                MenuIdConstants.kLastTransactionID) {
                              widget.routingHelper.navigateTo(
                                  SARPLPageRoutes.lastTransactionEMI);
                            } else if (data.menuID ==
                                MenuIdConstants.kServiceID) {
                              widget.routingHelper
                                  .navigateTo(SARPLPageRoutes.service);
                            } else if (data.menuID ==
                                MenuIdConstants.kMyCollectionID) {
                              widget.routingHelper
                                  .navigateTo(SARPLPageRoutes.myCustomer);
                            } else if (data.menuID ==
                                MenuIdConstants.kProposalForSARID) {}
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                      /* children: <Widget>[
                          
                          const ListTile(
                            title: Text("Home"),
                            trailing: Icon(Icons.new_releases),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("My Customer"),
                            trailing: const Icon(Icons.person),
                            onTap: () =>
                                {widget.routingHelper.navigateTo(SARPLPageRoutes.myCustomer)},
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("Tab Layout"),
                            trailing: const Icon(Icons.person),
                            onTap: () => {},
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("Comman View Demo"),
                            trailing: const Icon(Icons.person),
                            onTap: () => {},
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("Close"),
                            trailing: const Icon(Icons.close),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ], */
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
