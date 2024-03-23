import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';

import '../../presentation/bloc/authorize_bloc/authorize_bloc.dart';
import '../../presentation/bloc/login/login_bloc.dart';
import '../../presentation/cubit/login/login_cubit.dart';
import '../../presentation/cubit/version_info_app_cubit.dart';
import '../../presentation/pages/authorize/authorize_view.dart';
import '../../presentation/pages/login/login_view.dart';
import 'routes_name.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: RoutesName.authorizeRoute,
      builder: (__, GoRouterState state) {
        return MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<AuthorizeBloc>(
              create: (_) => AuthorizeBloc()..add(GetValidateUser()),
            ),
            BlocProvider<VersionInfoAppCubit>(
              create: (_) => VersionInfoAppCubit()..getApplicationInfo(),
            ),
          ],
          child: const AuthorizeView(),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (__, GoRouterState state) {
            return MultiBlocProvider(
              providers: <SingleChildWidget>[
                BlocProvider<LoginCubit>(
                  create: (_) => LoginCubit(),
                ),
                BlocProvider<LoginBloc>(
                  create: (_) => LoginBloc(),
                ),
              ],
              child: const LoginView(),
            );
          },
        ),
      ],
    ),
  ],
);
