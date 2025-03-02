import 'package:crudtutorial/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'widgets/main.dart';
import 'widgets/invalid_route.dart';
import 'values/app_routes.dart';
import 'package:crudtutorial/utils/shared_pref_utils.dart'; 

class Routes {
  const Routes._();   

  static Future<bool> _isUserAuthenticated() async {
    String? token = SharedPrefUtils.getString('token'); 
    return token != null && token.isNotEmpty;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> getRoute({required Widget widget, bool fullscreenDialog = false,}) {
      return MaterialPageRoute<void>(
        builder: (context) => widget,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      );
    }

    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute<void>(
          builder: (context) => FutureBuilder<bool>(
            future: _isUserAuthenticated(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }

              if (snapshot.hasData && snapshot.data == true) {
                return const MainScreen(); // ✅ Allow access if authenticated
              } else {
                return const LoginPage(); // ❌ Redirect to login if not authenticated
              }
            },
          ),
        );

      case AppRoutes.register: 
        return MaterialPageRoute<void>(
          builder: (context) => FutureBuilder<bool>(
            future: _isUserAuthenticated(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }

              if (snapshot.hasData && snapshot.data == true) {
                return const MainScreen(); // ✅ Allow access if authenticated
              } else {
                return const RegisterPage(); // ❌ Redirect to register if not authenticated
              }
            },
          ),
        );
        
      case AppRoutes.homeScreen:
        return MaterialPageRoute<void>(
          builder: (context) => FutureBuilder<bool>(
            future: _isUserAuthenticated(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }

              if (snapshot.hasData && snapshot.data == true) {
                return const MainScreen(); // ✅ Allow access if authenticated
              } else {
                return const LoginPage(); // ❌ Redirect to login if not authenticated
              }
            },
          ),
        );
        
      /// An invalid route. User shouldn't see this,
      /// it's for debugging purpose only.
      default:
        return getRoute(widget: const InvalidRoute());
    }
  }
}