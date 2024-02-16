
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/DialogUtils.dart';
import 'package:todo/database/moodle/user.dart' as myUser;
import 'package:todo/firebase_errors_codes.dart';
import 'package:todo/providers/authProviders.dart';
import 'package:todo/ui/common/customFormField.dart';
import 'package:todo/ui/log%20in/logInScreen.dart';
import 'package:todo/validationUtils.dart';
import '../../database/moodle/user.dao.dart ';
import 'package:todo/providers/authProviders.dart';
import 'package:flutter/src/widgets/framework.dart';
class RegisterScreen extends StatefulWidget{

  static String route = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullName = TextEditingController();

  TextEditingController userName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController passwordConfirmation = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage('assets/images/background.png'),
        fit: BoxFit.fill)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
            customFormField(
       label:'Full name' ,
            controller: fullName,
            validator: (text){
              if(text==null||text.trim().isEmpty){
                return 'please enter Full name ';
              }
              return null;
            },
       keyboardType: TextInputType.name,
   ),
            customFormField(
            label:'User name' ,
              controller: userName,
              validator: (text){
              if(text==null||text.trim().isEmpty){
                return 'please enter User name ';
              }
              return null;
              },
              keyboardType: TextInputType.name
      ),
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
            customFormField(
            label:'Password conformation' ,
            controller: passwordConfirmation,
            validator: (text){
              if(text==null||text.trim().isEmpty){
                return 'please enter Password conformation ';
              }
              if(text.length<6){
                return 'Password should at least 6 chars';
              }
              if(password.text!=text){
                return "password doesn't match";
              }
              return null;
            },
              keyboardType: TextInputType.text,
            secure: true,
      ),
      SizedBox(height: 20),
      ElevatedButton(onPressed:(){createAccount();}, child: Text('Creat Account')),
    TextButton(onPressed: (){
      Navigator.of(context).pushNamed(logInScreen.route);
    }, child: Text('alraedy have account !!'))
  ],
),
          ),
        ),
      ),
    );
  }

  void createAccount()async {
  if(formKey.currentState?.validate()== false ){
    return ;
  }
  var authProvider = Provider.of<AuuthProvider>(context, listen:  false);
  try{
DialogUtils.showLoading(context, 'loading.....');
 authProvider.register(email.text, password.text, userName.text, fullName.text);
 DialogUtils.hideDialog(context);
 DialogUtils.showMessage(context, 'sign up successfully ');
  }
  on FirebaseAuthException catch (e) {
    if (e.code == fireBaseErrorsCodes.weakPassword) {
      print('The password provided is too weak.');
    } else if (e.code == fireBaseErrorsCodes.emailInUse) {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
}
