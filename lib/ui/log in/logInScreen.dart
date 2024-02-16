import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/DialogUtils.dart';
import 'package:todo/firebase_errors_codes.dart';
import 'package:todo/ui/Home/homeScreen.dart';
import 'package:todo/ui/common/customFormField.dart';
import 'package:todo/validationUtils.dart';


import '../../DialogUtils.dart';
import '../../database/moodle/user.dao.dart  ' as getUser;
import '../../providers/authProviders.dart';
import '../register/rigisterScreen.dart';

class logInScreen extends StatefulWidget{
  static String route = 'logIn';

  logInScreen({super.key});

  @override
  State<logInScreen> createState() => _logInScreenState();
}

class _logInScreenState extends State<logInScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
          image: DecorationImage(image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: formKey,
          child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

          customFormField(
          label:'Email' ,
            controller: email,
            validator: (text){
              if(text==null||text.trim().isEmpty){
                return 'please enter Email ';
              }
              if(!isValidEmail(text)){
                return 'Email Bad format';
              }
              return null;
            },


            keyboardType: TextInputType.emailAddress
      ),
          customFormField(
          label:'password' ,
          controller:  password,
          validator: (text){
            if(text==null||text.trim().isEmpty){
              return 'please enter Password ';
            }
            if(text.length<6){
              return 'Password should at least 6 chars';
            }
            return null;
          },
            keyboardType: TextInputType.text,
          secure: true,
      ),
      SizedBox(height: 20),
      ElevatedButton(onPressed:(){logIn();}, child: Text('log in')),
    TextButton(onPressed: (){
      Navigator.of(context).pushNamed(RegisterScreen.route);
    }, child: Text('dont have account !!'))
  ],
),
        ),
      ),
    );
  }

  void logIn()  async{
  if(formKey.currentState?.validate()== false ){
    return ;
  }
  var authProvider = Provider.of<AuuthProvider>(context, listen: false);
  try  {
    DialogUtils.showLoading(context, 'loading....',isCancelable: false);
  await  authProvider.login(email.text, password.text);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessage(context, 'user login unsuccessfully '
       ,posActionTitle: 'ok',postAction: (){
      Navigator.pushNamed(context, homeScreen.route);
    });
  } on FirebaseAuthException catch (e) {
    DialogUtils.hideDialog(context);
    if (e.code == fireBaseErrorsCodes.userNotFound||
        e.code == fireBaseErrorsCodes.wrongPassword||
        e.code == fireBaseErrorsCodes.invalidCredential) {
      DialogUtils.showMessage(context, 'wrong Email or PassWord');
    }
  }
}
}
