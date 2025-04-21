import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_router.dart';

class AuthGuard extends AutoRouteGuard {
  

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isUserLoggedIn = FirebaseAuth.instance.currentUser;
    if (isUserLoggedIn != null) {
      resolver.next(true);
    } else {
      router.push(const AuthRoute());
    }
  }
}
