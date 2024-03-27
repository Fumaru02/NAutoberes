import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';

import '../../presentation/blocs/authorize/authorize_bloc.dart';
import '../../presentation/blocs/bloc/home_bloc.dart';
import '../../presentation/blocs/chat/chat_bloc.dart';
import '../../presentation/blocs/frame/frame_bloc.dart';
import '../../presentation/blocs/login/login_bloc.dart';
import '../../presentation/cubits/home/home_cubit.dart';
import '../../presentation/cubits/login/login_cubit.dart';
import '../../presentation/pages/authorize/authorize_view.dart';
import '../../presentation/pages/frame/frame_view.dart';
import '../../presentation/pages/login/forgot_password_view.dart';
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
          ],
          child: const AuthorizeView(),
        );
      },
    ),
    GoRoute(
      path: '/login',
      builder: (__, GoRouterState state) {
        return MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<LoginCubit>(
              create: (_) => LoginCubit(),
            ),
            BlocProvider<LoginBloc>(
              create: (_) => LoginBloc()..add(GetDataTermsFireBase()),
            ),
          ],
          child: const LoginView(),
        );
      },
    ),
    GoRoute(
      path: '/forgotpassword',
      builder: (__, GoRouterState state) {
        return BlocProvider<LoginBloc>.value(
          value: LoginBloc(),
          child: ForgotPasswordView(
            email: state.extra! as TextEditingController,
          ),
        );
      },
    ),
    GoRoute(
      path: '/frame',
      builder: (__, GoRouterState state) {
        return MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<FrameBloc>(create: (_) => FrameBloc()),
            BlocProvider<ChatBloc>(
              create: (_) => ChatBloc(),
            ),
            BlocProvider<HomeBloc>(
              create: (_) => HomeBloc(),
            ),
            BlocProvider<HomeCubit>(
              create: (_) => HomeCubit(),
            ),
          ],
          child: const Frame(),
        );
      },
    ),
  ],
);
