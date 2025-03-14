import 'package:flutter/material.dart';

class RoutingHelper {
  final GlobalKey<NavigatorState> navigatorKey;

  RoutingHelper({required this.navigatorKey});

  // Common navigation function
  Future<void> navigateTo(String routeName,
      {Object? arguments, bool replace = false}) async {
    if (replace) {
      // Replace current route with the new one
      await navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    } else {
      // Push new route onto the stack
      await navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }

  // Pop the current route (go back to the previous screen)
  void goBack() {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pop();
    }
  }

  // Navigate to a route and clear the stack (useful for login/logout scenarios)
  Future<void> navigateToAndClearStack(String routeName,
      {Object? arguments}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  // Navigate with a custom transition (if required)
  Future<void> navigateWithTransition(Widget page, {Object? arguments}) async {
    await navigatorKey.currentState!.push(MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(arguments: arguments),
    ));
  }
}

class CurrentNavigationObserver extends NavigatorObserver {
  final List<Route> _routeStack = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.add(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute == null) {
      if (newRoute != null) {
        // Add the route to the top?
        _routeStack.add(newRoute);
      }
      return;
    }

    // Probably never happens, but anyway..
    if (newRoute == null) {
      _routeStack.remove(oldRoute);
      return;
    }

    if (_routeStack.contains(oldRoute)) {
      _routeStack[_routeStack.indexOf(oldRoute)] = newRoute;
    } else {
      // Add the route to the top?
      _routeStack.add(newRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.remove(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.remove(route);
  }
}
