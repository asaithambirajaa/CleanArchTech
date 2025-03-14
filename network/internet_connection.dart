import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

//network check
ConnectivityResult connectionStatus = ConnectivityResult.none;
final Connectivity connectivity = Connectivity();
late StreamSubscription<ConnectivityResult> connectivitySubscription;

class Amenities {
  Amenities._();

  static Amenities instance = Amenities._();

  Future<List<ConnectivityResult>?> connectivityChecker() async {
    late List<ConnectivityResult> result;
    try {
      result = await connectivity.checkConnectivity();
      updateConnectionStatus(result);
    } catch (e) {
      return null;
    }
    return result;
  }

  Future<void> updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      connectionStatus = ConnectivityResult.none;
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        // context.read<BaseViewCubit>().showNoIneternetConnection();
      }
    } else if (result.contains(ConnectivityResult.mobile) ||
        (result.contains(ConnectivityResult.wifi))) {
      connectionStatus = ConnectivityResult.mobile;
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        // context.read<BaseViewCubit>().backToOnline();
      }
    }
  }
}

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityCubit() : super(ConnectivityInitial());

  void checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _emitConnectivityState(result);
  }

  void startListening() {
    _connectivity.onConnectivityChanged.listen((result) {
      _emitConnectivityState(result);
    });
  }

  _emitConnectivityState(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      // emit(ConnectivityConnected());
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(content: Text("You are connected!")),
      );
    } else {
      //emit(ConnectivityDisconnected());
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text("No internet connection!")),
      );
    }
  }
}

abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {}

class ConnectivityDisconnected extends ConnectivityState {}
