import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/router/app_router_path.dart';
import 'package:flutter_base/src/features/splash/presentation/state/splash_bloc.dart';
import 'package:flutter_base/src/features/splash/presentation/state/splash_event.dart';
import 'package:flutter_base/src/features/splash/presentation/state/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/src/injector.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<SplashBloc>()..add(CheckAuthStatus()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) async {
          // Biraz bekleme süresi ekleyelim ki logo görünsün
          await Future.delayed(const Duration(milliseconds: 1500));

          if (state is Authenticated) {
            context.router.replaceNamed(RouterPath.home);
          } else if (state is Unauthenticated) {
            context.router.replaceNamed(RouterPath.login);
          }
        },
        child: Scaffold(
          body: SizedBox.expand(
            child: Image.asset(
              'assets/images/cinmax.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
