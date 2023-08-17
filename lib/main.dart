import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wiseki/datasource/darkmode.dart';
import 'package:wiseki/screens/home_screen.dart';

void main() {
  runApp(ProviderScope(
    child:  MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final themMode = ref.watch(themeModeProvider);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData(
          textTheme: GoogleFonts.archivoTextTheme(Theme.of(context).textTheme)
              .apply(
                  fontSizeFactor: 1.2.sp,
                  bodyColor: Colors.white,
                  decorationColor: Colors.white,
                  displayColor: Colors.white),
          brightness: Brightness.dark,
        ),
        theme: ThemeData(
          textTheme: GoogleFonts.archivoTextTheme(Theme.of(context).textTheme)
              .apply(fontSizeFactor: 1.sp),
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode: themMode,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: const HomeScreen(),
      ),
    );
  }
}

