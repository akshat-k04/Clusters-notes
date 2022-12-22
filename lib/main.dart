import 'package:clusters/provider/notes_provider.dart';
import 'package:clusters/screens/signupLogin/Login_pg.dart';
import 'package:clusters/screens/signupLogin/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( FirstPg());
}


class FirstPg extends StatelessWidget{
  final Future<FirebaseApp> _fbApp =Firebase.initializeApp();
   FirstPg({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        )
      ],
      child:
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: _fbApp,
            builder: (context,snapshot){
              if(snapshot.hasError){

                print('yu have an error ${snapshot.error.toString()}');

                return const Text('something wents wrong');
              }
              else if (snapshot.hasData){
                return const Splash() ;
              }
              else {
                return const Text('something wents wrong');
              }
            },
          )

        //
      ),
    ) ;

  }

}