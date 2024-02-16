import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/authProviders.dart';
import 'package:todo/ui/Home/homeScreen.dart';

class splashScreen extends StatelessWidget {
  static const String route= 'splashScreen';
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      navigate(context);
    });
    return Scaffold(
      body: Image.asset('assets/images/splash_screen.png',
      fit: BoxFit.contain),
    );
  }

  void navigate(BuildContext context)async {
    var authProvider = Provider.of<AuuthProvider>(context,listen: false);
    if(authProvider.isUserLoggedInBefore()){
       await authProvider.retieveUserfromDatabase();
      Navigator.pushReplacementNamed(context, homeScreen.route);
    }else{
      Navigator.pushReplacementNamed(context, homeScreen.route);
    }
  }
}
