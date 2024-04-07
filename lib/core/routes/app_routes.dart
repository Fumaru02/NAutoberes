import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';

import '../../domain/models/about_automotive_model.dart';
import '../../domain/models/brands_car_model.dart';
import '../../domain/models/specialist_model.dart';
import '../../presentation/blocs/authorize/authorize_bloc.dart';
import '../../presentation/blocs/chat/chat_bloc.dart';
import '../../presentation/blocs/frame/frame_bloc.dart';
import '../../presentation/blocs/home/home_bloc.dart';
import '../../presentation/blocs/home_service_manager/home_service_manager_bloc.dart';
import '../../presentation/blocs/login/login_bloc.dart';
import '../../presentation/blocs/maps/maps_bloc.dart';
import '../../presentation/cubits/home/home_cubit.dart';
import '../../presentation/cubits/home_service_manager/home_service_manager_cubit.dart';
import '../../presentation/cubits/login/login_cubit.dart';
import '../../presentation/pages/akun/home_service_manager_view.dart';
import '../../presentation/pages/akun/widgets/select_brands.dart';
import '../../presentation/pages/akun/widgets/select_specialist.dart';
import '../../presentation/pages/authorize/authorize_view.dart';
import '../../presentation/pages/chat/chat_room_view.dart';
import '../../presentation/pages/frame/frame_view.dart';
import '../../presentation/pages/home/widgets/lihat_semua_view.dart';
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
            BlocProvider<ChatBloc>(
              create: (_) => ChatBloc()..add(UserChats()),
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
    GoRoute(
      path: '/lihatsemua',
      builder: (__, GoRouterState state) {
        return LihatSemuaView(
          aboutAutomotiveList: state.extra! as List<AboutAutomotiveModel>,
        );
      },
    ),
    GoRoute(
      path: '/chat',
      builder: (__, GoRouterState state) {
        return BlocProvider<ChatBloc>(
          create: (_) => ChatBloc(),
        );
      },
    ),
    GoRoute(
      path: '/homeservicemanager',
      builder: (__, GoRouterState state) {
        return MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<HomeServiceManagerBloc>(
              create: (_) => HomeServiceManagerBloc(),
            ),
            BlocProvider<HomeServiceManagerCubit>(
              create: (_) => HomeServiceManagerCubit(),
            ),
            BlocProvider<MapsBloc>(
              create: (_) => MapsBloc(),
            ),
          ],
          child: const HomeServiceManagerView(),
        );
      },
    ),
    GoRoute(
      path: '/selectbrands',
      builder: (__, GoRouterState state) {
        return MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<HomeServiceManagerCubit>.value(
              value: HomeServiceManagerCubit(),
            ),
            BlocProvider<HomeServiceManagerBloc>.value(
              value: HomeServiceManagerBloc(),
            ),
          ],
          child:
              SelectBrands(brandlistCar: state.extra! as List<BrandsCarModel>),
        );
      },
    ),
    GoRoute(
      path: '/selectspecialist',
      builder: (__, GoRouterState state) {
        return MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<HomeServiceManagerCubit>.value(
              value: HomeServiceManagerCubit(),
            ),
            BlocProvider<HomeServiceManagerBloc>.value(
              value: HomeServiceManagerBloc(),
            ),
          ],
          child: SelectSpecialist(
              specialList: state.extra! as List<SpecialistModel>),
        );
      },
    ),
    GoRoute(
      path: '/chatroom',
      builder: (__, GoRouterState state) {
        final Map<String, dynamic> data = state.extra! as Map<String, dynamic>;
        return BlocProvider<ChatBloc>.value(
          value: ChatBloc(),
          child: ChatRoomView(
            targetName: data['targetName'] as String,
            chatId: data['chatId'] as String,
            targetPic: data['targetPic'] as String,
            targetUid: data['targetUid'] as String,
            userUid: data['userUid'] as String,
          ),
        );
      },
    ),
  ],
);
