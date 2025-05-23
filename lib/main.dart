import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import 'routes/app_routes.dart';
import 'utils/size_config.dart';
import 'views/authorize/authorize_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const AutoBeres());
}

class AutoBeres extends StatelessWidget {
  const AutoBeres({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      title: 'AutoBeres',
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) =>
          ResponsiveBreakpoints(breakpoints: const <Breakpoint>[
        Breakpoint(
          start: 0,
          end: 480,
        )
      ], child: child!),
      home: const AuthorizeView(),
      getPages: AppRoutes.routes,
      defaultTransition: Transition.noTransition,
    );
  }
}
