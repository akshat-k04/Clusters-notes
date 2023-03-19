import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class prof extends StatefulWidget {
  const prof({super.key});

  @override
  State<StatefulWidget> createState() {
    return Profile();
  }



}

class Profile extends State<prof> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE3FFFFFF),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'My Profile',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.black,
              fontFamily: 'Schyler'
            ),
          ),
        ),

        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.edit),
        //     color: Colors.black,
        //     tooltip: 'edit',
        //     onPressed: () {
        //
        //     },
        //   ),
        // ],
        automaticallyImplyLeading: false,
        // leading:IconButton(
        //   icon: const Icon(Icons.backspace_outlined),
        //   color: Colors.black,
        //   tooltip: 'edit',
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePg()));
        //     ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text('snakebar')));
        //   },
        // ) ,
      ),
      body: Center(
        child: Column(
          children: const [
            Padding(padding: EdgeInsets.only(top: 90.0)),

            Icon(
              Icons.person,
              size: 120.0,
            ),
            SizedBox(
              height: 50.0,
            ),

            SizedBox(
              height: 10.0,
            ),

          ],
        ),
      ),
    );
  }
}
