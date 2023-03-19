import 'package:clusters/screens/After_login/profile_pg.dart';
import 'package:clusters/screens/drawing/drawYourDay.dart';
import 'package:clusters/screens/notes/notes.dart';
import 'package:clusters/screens/signupLogin/Login_pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/notes_provider.dart';

class HomePg extends StatefulWidget {
  var phone;
  HomePg({super.key, this.phone});

  @override
  State<StatefulWidget> createState() {
    return Homeg(phon: phone);
  }
}

class Homeg extends State<HomePg> {
  var phon;

  int _selectedIndex = 0;
  Homeg({required this.phon});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).fetchnotes(phon);
  }
  void gotoPages(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (_selectedIndex == 0)
          ? AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.grey),

              title: const Center(
                child: Image(
                  image: AssetImage('assets/images/name.png'),
                  fit: BoxFit.cover,
                  height: 30.0,
                ),
              ),

              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  color: Colors.grey,
                  tooltip: 'user profile',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const prof()));

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //const SnackBar(content: Text('This is a snackbar')));
                  },
                ),
              ],

              // leading: IconButton(
              //   icon: const Icon(Icons.sticky_note_2_sharp),
              //   color: Colors.black,
              //   onPressed: () {
              //     Provider.of<NotesProvider>(context,listen: false).fetchnotes(phon) ;
              //     Navigator.push(context, MaterialPageRoute(builder: (_) => Notes(phone: phon,)));
              //   },
              //   tooltip:'Show Snackbar' ,
              // ),
            )
          : null,
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children:  <Widget>[
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            accountName: Text(
              'jj',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            accountEmail: Text(
              "gbg",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFFDC4654),
              //foregroundImage: ,
              child: Text(
                'dd',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            title: Text('About us'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Terms of service'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('life Hacks'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: ()async {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPg()),
                      (Route<dynamic> route) => false);
              SharedPreferences preferences = await SharedPreferences.getInstance();
              await preferences.remove('username');
              await preferences.clear();
            },
          ),
        ]),
        //backgroundColor: Colors.grey,
      ),
      body: (_selectedIndex == 0) ? null : (_selectedIndex==1)?Drawing() :Notes(phone: phon),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_rounded),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.draw_rounded),
            label: 'drawing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
        ],
        selectedItemColor: Color(0xFFDF96B0),
        currentIndex: _selectedIndex,
        onTap: gotoPages,
      ),
    );
  }
}
