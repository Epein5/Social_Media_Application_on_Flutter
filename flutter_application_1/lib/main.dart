import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utlis/routes/routes.dart';
import 'package:flutter_application_1/serivces/provider/NightMode.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NightModeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => LoadingProvider())],
        child: Builder(builder: (BuildContext context) {
          final nightProvider = Provider.of<NightModeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: nightProvider.thememode,
            theme: ThemeData(primarySwatch: Colors.purple),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color.fromARGB(255, 29, 1, 35)),
            onGenerateRoute: Routes.generateRoutes,
            initialRoute: RouteName.splashview,
          );
        }));
  }
}
