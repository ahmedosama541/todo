import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoading(BuildContext context,
      String message,{bool isCancelable = true
  } ){
    showDialog(context: context, builder: (BuildContext){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 10,),
            Text(message),
          ],
        ),

      );
    },
      barrierDismissible: isCancelable
    );

  }
  static void hideDialog(BuildContext context){
    Navigator.pop(context);
  }
  static void showMessage(BuildContext context,
      String message,{
    String? posActionTitle,
        String? negsActionTitle,
        VoidCallback? postAction,
        VoidCallback? negAction,
        bool isCancelable = true
      } ){
    List<Widget>actions=[];
    if(posActionTitle!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        postAction?.call();
      }, child:
      Text(posActionTitle)));
    }
    if(negsActionTitle!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      }, child:
      Text(negsActionTitle)));
    }
    
    showDialog(context: context, builder: (BuildContext){
      return AlertDialog(
        actions: actions,
        content: Row(
          children: [
            Expanded(child: Text(message)),
          ],
        ),

      );
    },
        barrierDismissible: isCancelable
    );

  }
}