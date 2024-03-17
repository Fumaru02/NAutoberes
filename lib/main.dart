import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'controllers/authorize_controller.dart';
import 'routes/app_routes.dart';
import 'utils/size_config.dart';
import 'views/authorize/authorize_view.dart';

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
    // Menginisialisasi `AuthorizeController` menggunakan `Get.put`.
    Get.put(AuthorizeController());

    // Menginisialisasi `SizeConfig` dengan konteks saat ini.
    SizeConfig().init(context);

    return GetMaterialApp(
      theme: ThemeData(useMaterial3: false),
      title: 'AutoBeres',
      debugShowCheckedModeBanner: false,

      // Membangun tata letak responsif berdasarkan breakpoint.
      builder: (BuildContext context, Widget? child) =>
          ResponsiveBreakpoints.builder(
        breakpoints: const <Breakpoint>[
          Breakpoint(start: 0, end: 480, name: MOBILE),
        ],
        child: child!,
      ),

      // Mengatur halaman awal aplikasi menjadi `AuthorizeView`.
      home: const AuthorizeView(),

      // Mengatur rute aplikasi menggunakan `AppRoutes.routes`.
      getPages: AppRoutes.routes,

      // Mengatur transisi default menjadi `Transition.noTransition`.
      defaultTransition: Transition.noTransition,
    );
  }
}
