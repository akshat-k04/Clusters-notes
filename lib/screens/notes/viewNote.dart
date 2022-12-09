import 'package:flutter/material.dart';

import '../../models/notemodel.dart';

class ViewNote extends StatefulWidget {
  Notemodel note;
  ViewNote({super.key,
    required this.note
});
  @override
  State<StatefulWidget> createState() {
    return ViewNoteState() ;
  }

}
class ViewNoteState extends State<ViewNote>{
  @override
  Widget build(BuildContext context) {
   return Container(
     decoration: const BoxDecoration(
       image: DecorationImage(
           image: AssetImage("assets/images/notesAddBackground.jpg"),
           fit: BoxFit.cover),
     ),



     child: Scaffold(


       backgroundColor: Colors.transparent,


       floatingActionButton: FloatingActionButton(
         onPressed: () {Navigator.pop(context) ;},
         backgroundColor: Colors.black,
         child: const Icon(
           Icons.backspace_outlined,
           //color: Colors.black,
         ),
       ),


       body: SingleChildScrollView(
         child: SafeArea(
           child: Column(
             children: [




               const SizedBox(
                 height: 170,
               ),




               Center(
                 child: Container(
                   width: 320.0,
                   height: 430.0,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15.0),
                     color: Colors.white,
                   ),
                   child: Padding(

                     padding: const EdgeInsets.all(8.0),
                     child: Column(



                       children:  [

                         Text(widget.note.titlef! ,


                           style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),

                         ),




                         const Divider(
                           color: Colors.black,
                           indent: 60.0,
                           endIndent: 60.0,
                         ),





                         Expanded(
                           child: SingleChildScrollView(
                             child: Text(widget.note.contentf!,

                               style: const TextStyle(
                                 fontSize: 15.0,
                               ),

                             ),
                           ),
                         ),


                         const Divider(
                           color: Colors.black,
                           indent: 20.0,
                           endIndent: 20.0,
                         ),




                         const SizedBox(
                           height: 30,
                         ),
                         // IconButton(
                         //   splashColor: Colors.orange,
                         //     onPressed: (){},
                         //     icon: const Icon(
                         //       Icons.done,
                         //       color: Colors.blueGrey,
                         //     ),
                         // ),




                       ],
                     ),

                   ),
                 ),
               ),

             ],
           ),
         ),
       ),
     ),
   );
  }

}

