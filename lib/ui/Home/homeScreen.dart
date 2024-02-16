import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/DialogUtils.dart';
import 'package:todo/providers/authProviders.dart';
import 'package:todo/ui/Home/settings/settingsTab.dart';
import 'package:todo/ui/Home/taskList/taskListTab.dart';
import 'package:todo/ui/log%20in/logInScreen.dart';

class homeScreen extends StatefulWidget {
  static String route = 'homeScreen';
  @override
  State<homeScreen> createState() => _homeScreenState();
}
class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text('todo App'),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: (){
            Logout();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 4
        )
      ),
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            setState(() {
              selectedIndex=index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: '')
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
  int selectedIndex = 0;

  var tabs = [taskTab(),settingsTap()];

  Logout() {
    var authProvider = Provider.of<AuuthProvider>(context,listen: false);
  DialogUtils.showMessage(context, 'are you sure to logout',
    posActionTitle: 'yes',
    postAction:() {authProvider.logout();
      Navigator.of(context).pushReplacementNamed(logInScreen.route);},
    negsActionTitle: 'cancel'

  );
  }
}
