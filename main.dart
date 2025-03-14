import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sarpl/core/features/kyc_document_details_lang/presentation/cubit/kyc_language_cubit.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sarpl/features/auth/presentation/pages/auth_page.dart';
import 'package:sarpl/features/auth/presentation/pages/change_password_page.dart';
import 'package:sarpl/features/customer_loan_info/presentation/cubit/customer_loan_info_cubit.dart';
import 'package:sarpl/features/customer_loan_info/presentation/pages/my_customer_page.dart';
import 'package:sarpl/features/customer_loan_info/presentation/pages/view_loan_details_page.dart';
import 'package:sarpl/features/home_page.dart';
import 'package:sarpl/features/service/presentation/cubit/service_cubit.dart';
import 'package:sarpl/features/service/presentation/pages/change_request_foream_page.dart';
import 'package:sarpl/features/service/presentation/pages/change_request_page.dart';
import 'package:sarpl/features/service/presentation/pages/service_search_page.dart';
import 'package:sarpl/features/splash_page.dart';
import 'package:sarpl/features/transaction/presentation/pages/last_transaction_page.dart';
import 'package:sarpl/injection_container.dart' as di;

import 'core/core.dart';
import 'features/auth/presentation/pages/change_mpin_page.dart';
import 'features/customer_loan_info/presentation/pages/collection_page.dart';
import 'features/service/presentation/pages/customer_view_page.dart';
import 'features/transaction/presentation/cubit/last_transaction_cubit.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initLocalStorage();
  final navigatorKey = GlobalKey<NavigatorState>();
  final routingHelper = RoutingHelper(navigatorKey: navigatorKey);
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.dev,
  );
  Environment().initConfig(environment);
  await di.init();
  runApp(
    MyApp(
      routingHelper: routingHelper,
    ),
  );
}

class MyApp extends StatelessWidget {
  final RoutingHelper routingHelper;
  const MyApp({super.key, required this.routingHelper});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ConnectivityCubit>()),
        BlocProvider(create: (_) => di.sl<AuthCubit>()),
        BlocProvider(create: (_) => di.sl<KycLanguageCubit>()),
        BlocProvider(create: (_) => di.sl<CustomerLoanInfoCubit>()),
        BlocProvider(create: (_) => di.sl<LastTransactionCubit>()),
        BlocProvider(create: (_) => di.sl<ServiceCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: routingHelper.navigatorKey,
        title: StringConstants.applicationName,
        initialRoute: SARPLPageRoutes.initial,
        routes: {
          SARPLPageRoutes.initial: (context) =>
              SplashPage(routingHelper: routingHelper),
          SARPLPageRoutes.login: (context) =>
              AuthPage(routingHelper: routingHelper),
          SARPLPageRoutes.changePassword: (context) =>
              ChangePasswordPage(routingHelper: routingHelper),
          SARPLPageRoutes.changeMpin: (context) =>
              ChangeMpinPage(routingHelper: routingHelper),
          SARPLPageRoutes.home: (context) =>
              HomePage(routingHelper: routingHelper),
          SARPLPageRoutes.myCustomer: (context) =>
              MyCustomerPage(routingHelper: routingHelper),
          SARPLPageRoutes.viewLoanDetails: (context) =>
              ViewLoanDetailsPage(routingHelper: routingHelper),
          SARPLPageRoutes.collection: (context) =>
              CollectionPage(routingHelper: routingHelper),
          SARPLPageRoutes.lastTransactionEMI: (context) =>
              LastTransactionPage(routingHelper: routingHelper),
          SARPLPageRoutes.service: (context) =>
              ServiceSearchPage(routingHelper: routingHelper),
          SARPLPageRoutes.serviceCustomerView: (context) =>
              CustomerViewPage(routingHelper: routingHelper),
          SARPLPageRoutes.changeRequestService: (context) =>
              ChangeRequestPage(routingHelper: routingHelper),
          SARPLPageRoutes.changeRequestServiceForEAM: (context) =>
              ChangeRequestForEAMPage(routingHelper: routingHelper),
        },
        theme: AppTheme.themeData,
      ),
    );
  }
}
