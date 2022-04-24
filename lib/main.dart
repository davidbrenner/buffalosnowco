import 'package:buffalosnowco/dashboard_screen.dart';
import 'package:buffalosnowco/screens/create_request.dart';
import 'package:buffalosnowco/screens/find_jobs.dart';
import 'package:buffalosnowco/transition_route_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Color(0xffffd200)),
        textTheme: GoogleFonts.montserratTextTheme(),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.yellow),
      ),
      navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginScreen.routeName,
      //initialRoute: DashboardScreen.routeName,
      routes: {
        DashboardScreen.routeName: (context) => const DashboardScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        //DashboardScreen.routeName: (context) => const DashboardScreen(),
        FindJobsScreen.routeName: (context) => const FindJobsScreen(),
        CreateRequestScreen.routeName: (context) => const CreateRequestScreen(),
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
