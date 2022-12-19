import 'package:clusters/models/notemodel.dart';
import 'package:clusters/provider/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNote extends StatefulWidget {
  final phone;
  final update;
  Notemodel? NoteForUpdate ;

  AddNote({super.key, required this.phone, required this.update , this.NoteForUpdate});

  @override
  State<StatefulWidget> createState() {
    return AddNoteState();
  }
}

class AddNoteState extends State<AddNote> {
  TextEditingController titlecont = TextEditingController() ;
  TextEditingController contentcont = TextEditingController() ;

  FocusNode nodeFocus = FocusNode();

  @override
  void initState() {

    super.initState();
    if(widget.update){
      titlecont.text = widget.NoteForUpdate!.titlef! ;
      contentcont.text = widget.NoteForUpdate!.contentf! ;
    }
  }

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
            onPressed: () {operate();},
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.done,
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

                            TextField(
                              controller: titlecont,
                              onSubmitted: (val){
                                if(val!=""){
                                  nodeFocus.requestFocus();
                                }
                              },
                              autofocus:(widget.update == true)?false: true,
                              cursorColor: Colors.blueGrey,
                              style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(

                                  hintText: "Title", border: InputBorder.none),
                            ),




                            const Divider(
                              color: Colors.black,
                              indent: 60.0,
                              endIndent: 60.0,
                            ),





                            Expanded(
                              child: TextField(
                                controller: contentcont,
                                focusNode: nodeFocus,
                                cursorColor: Colors.blueGrey,
                                maxLines: null,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                                decoration: const InputDecoration(
                                    hintText: "note", border: InputBorder.none),
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

   void operate (){
    if(widget.update){
      widget.NoteForUpdate!.titlef = titlecont.text ;
      widget.NoteForUpdate!.contentf = contentcont.text ;
      widget.NoteForUpdate!.dateAddedf = DateTime.now();
      Provider.of<NotesProvider>(context,listen: false).updateNote(widget.NoteForUpdate!) ;

    }
    else{

      Notemodel modelToAdd = Notemodel(
        idf: const Uuid().v1() ,
        titlef: titlecont.text ,
        contentf: contentcont.text ,
        useridf: widget.phone ,
        dateAddedf: DateTime.now()
      );
      // we made a model now its time to add the note
      // so we need provider which we already create
      // lets call it
      Provider.of<NotesProvider>(context,listen: false).addNote(modelToAdd) ;
    }
    Navigator.pop(context);
   }

}
