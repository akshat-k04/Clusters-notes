import 'package:clusters/screens/After_login/profile_pg.dart';
import 'package:clusters/screens/notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/notes_provider.dart';


class HomePg extends StatefulWidget{
  var phone;

   HomePg({super.key,
   this.phone});



  @override
  State<StatefulWidget> createState() {
    return Homeg(phon: phone);
  }

}

class Homeg extends State<HomePg> {
  var phon;

   Homeg({
    required this.phon
  });

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark
          ),
          backgroundColor: Colors.white,
          title: const Center(
            child: Image(
              image: AssetImage('assets/images/name.png'),
              fit: BoxFit.cover,

              height: 30.0,
            ),
          ),

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person_rounded),
              color: Colors.black,
              tooltip: 'user profile',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => const prof()));

                // ScaffoldMessenger.of(context).showSnackBar(
                //const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],



          leading: IconButton(
            icon: const Icon(Icons.sticky_note_2_sharp),
            color: Colors.black,
            onPressed: () {
              Provider.of<NotesProvider>(context,listen: false).fetchnotes(phon) ;
              Navigator.push(context, MaterialPageRoute(builder: (_) => Notes(phone: phon,)));
            },
            tooltip:'Show Snackbar' ,
          ),

        ) ,
        body: SingleChildScrollView(
          child: Column(
            children:  [

            ],
          ),
        ),

    );

  }
}
