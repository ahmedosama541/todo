

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/moodle/user.dart' as myUser ;


import '../database/moodle/user.dao.dart  ';
class AuuthProvider extends ChangeNotifier{
  User?firebaseAuthUser ;
  myUser.User? databaseUser ;
 Future<void >register (
      String email , String password , String userName,String fullName
      ) async{
    var result = await  FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email,
        password: password);
    await UserDao.createUser(myUser.User(
      id:result.user?.uid ,
      fullName: fullName ,
      email:email ,
      userName: userName,
    )
    );
  }
  Future<void> login(String email , String password )async{
    final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    var user = await UserDao.getUser(result.user!.uid);
    databaseUser = user;
    firebaseAuthUser= result.user;
  }

  void logout() {
   databaseUser = null;
   FirebaseAuth.instance.signOut();
  }

  bool isUserLoggedInBefore() {
  return FirebaseAuth.instance.currentUser!=null;
  }

 Future<void>retieveUserfromDatabase() async{
   firebaseAuthUser = FirebaseAuth.instance.currentUser;
   databaseUser = await UserDao.getUser(firebaseAuthUser!.uid);
  }
}