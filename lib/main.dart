import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/repositories/repositories.dart';
import 'package:easy_coupon/services/services.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthRepository authRepository = AuthRepository(
    firebaseAuthService: FirebaseAuthService(),
  );

  // Make the app full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.textColor,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness:
        !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: AppColors.textColor,
    systemNavigationBarDividerColor: AppColors.textColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider<ReportBloc>(
          create: (context) => ReportBloc(ReportRepository()),
        ),
        BlocProvider(
          create: (context) => CanteenBloc(FirebaseFirestore.instance),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(
          ThemeData.light().copyWith(
            // scaffoldBackgroundColor: const Color(0xFFF9E6BD),
          ),
        ),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Easy Coupon',
              theme: themeProvider.themeData.copyWith(
                scaffoldBackgroundColor: const Color(0xFFFF8A00),
              ),
              initialRoute: RouteNames.login,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
