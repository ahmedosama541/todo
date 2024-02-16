import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/providers/authProviders.dart';
import 'package:todo/ui/Home/homeScreen.dart';
import 'package:todo/ui/log%20in/logInScreen.dart';
import 'package:todo/ui/register/rigisterScreen.dart';
import 'package:todo/ui/splashScreen_todo/splashScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(create: (BuildContext context) => AuuthProvider(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,
        primary: Colors.blue,),
        useMaterial3: false,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue
        ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue
      )
      ),
      routes: {
        RegisterScreen.route : (_)=>RegisterScreen(),
        logInScreen.route:(_)=>logInScreen(),
        homeScreen.route:(_)=>homeScreen(),
        splashScreen.route:(_)=>splashScreen()
      },
      initialRoute:splashScreen.route
    );
  }
}
