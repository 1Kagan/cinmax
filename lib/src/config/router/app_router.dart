import 'package:auto_route/auto_route.dart' show AutoRoute, AutoRouterConfig;
import 'package:flutter_base/src/config/router/app_router.gr.dart';
import 'package:flutter_base/src/config/router/app_router_path.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: RouterPath.splash,
          initial: true,
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: RouterPath.login,
        ),
        AutoRoute(
          page: RegisterRoute.page,
          path: RouterPath.register,
        ),
        AutoRoute(
          page: DashboardRoute.page,
          path: RouterPath.home,
        ),
        AutoRoute(
          page: UploadPhotoRoute.page,
          path: RouterPath.uploadPhoto,
        ),
      ];
}
