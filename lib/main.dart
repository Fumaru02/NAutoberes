import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/helpers/snackbar.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/enums.dart';
import 'core/utils/size_config.dart';
import 'presentation/cubits/shared_cubit.dart';

/// Fungsi utama aplikasi Flutter.
Future<void> main() async {
  // Memastikan binding Flutter diinisialisasi.
  WidgetsFlutterBinding.ensureInitialized();

  // Menginisialisasi Firebase.
  await Firebase.initializeApp();

  // Mengatur orientasi layar yang diinginkan.
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Menjalankan aplikasi AutoBeres.
  runApp(const AutoBeres());
}

//3.19.2
/// Kelas utama aplikasi AutoBeres yang mengimplementasikan `StatelessWidget`.
class AutoBeres extends StatelessWidget {
  /// Konstruktor untuk kelas `AutoBeres`.
  const AutoBeres({super.key});

  @override
  Widget build(BuildContext context) {
    // Menginisialisasi `SizeConfig` dengan konteks saat ini.
    SizeConfig().init(context);

    return BlocProvider<SharedCubit>(
      create: (_) => SharedCubit(),
      child: MaterialApp.router(
        builder: (BuildContext context, Widget? child) =>
            ResponsiveBreakpoints.builder(
          breakpoints: const <Breakpoint>[
            Breakpoint(
              start: 0,
              end: 480,
              name: MOBILE,
            ),
          ],
          child: BlocListener<SharedCubit, SharedState>(
            listener: (_, SharedState state) {
              if (state.connectionType == 3 || state.connectionType == 4) {
                Snack.showSnackBar(context,
                    messageInfo: 'Network error',
                    message: 'Please check yout internet connection',
                    snackbarType: SnackbarType.error);
              }
            },
            child: child,
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'AutoBeres',
        theme: ThemeData(useMaterial3: false),
        routerConfig: router,
      ),
    );
  }
}
