

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/moodle/user.dart';

class UserDao{
 static CollectionReference <User> getUserCollection(){
    var db = FirebaseFirestore.instance;
    var usersCollection= db.collection(User.collectionName).
    withConverter(
        fromFirestore: (snapshot, options) => User.fromFirestore(snapshot.data()),
        toFirestore: (object,options)=>object.toFirestore()
    );
    return usersCollection;
  }
  static Future<void> createUser(User user){
   var usersCollection = getUserCollection();
  var doc = usersCollection.doc(user.id);
  return
  doc.set(user);


}
 static Future<User?> getUser (String uid) async{
   var doc = getUserCollection().doc(uid);
   var docSnapshot = await doc.get();
   return docSnapshot.data();
 }
}