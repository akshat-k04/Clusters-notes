import 'package:clusters/models/notemodel.dart';
import 'package:clusters/provider/notes_provider.dart';
import 'package:clusters/screens/notes/viewNote.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../API services/api_services.dart';
import 'addNewNote.dart';

class Notes extends StatefulWidget {
  final phone;
  const Notes({super.key, required this.phone});
  @override
  State<StatefulWidget> createState() {
    return NotesState();
  }
}

class NotesState extends State<Notes> {
    bool? isUpdate ;
    String searchquery ="" ;
  @override

    Widget build(BuildContext context) {
    NotesProvider provideNotesToUs = Provider.of<NotesProvider>(context) ;
    return Scaffold(

        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),


          backgroundColor: Colors.white,


          title: const Text(
            "Note it down",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Schyler'),
          ),


          automaticallyImplyLeading: false,

        ),



        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNote(phone:widget.phone ,update:false)));
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.note_add),
        ),

        body: (NotesProvider.isLoading ==false)? RefreshIndicator(
          color: Colors.black,
          onRefresh: () async {
            await ApiServices.fetchnotes(widget.phone) ;
            },
          child:  SafeArea(
                child: (provideNotesToUs.notes.length>0)?ListView(

                    children:[

                      Padding(
                          padding:const EdgeInsets.all(8.0),
                        child:TextField(
                          onChanged: (val){
                            setState(() {
                              searchquery= val ;
                            });
                          },
                          decoration: const InputDecoration(
                            isDense: true,                      // Added this
                            contentPadding: EdgeInsets.all(16),
                              hintText: 'search',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                borderSide: BorderSide(

                                  color: Colors.black,
                                )
                            ),
                            border:    OutlineInputBorder(

                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),

                            ),
                            hintStyle: TextStyle(
                              color: Colors.black38,
                            ),

                          ),


                        ),
                      ),

                      (provideNotesToUs.filteredNotes(searchquery).length>0)?GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: provideNotesToUs.filteredNotes(searchquery).length,
                    itemBuilder: (context,index){
                      Notemodel currentnote = provideNotesToUs.filteredNotes(searchquery)[index] ;
                      return Dismissible(
                        key: ValueKey(currentnote.idf.toString()),
                        direction: DismissDirection.horizontal,

                        confirmDismiss: (direction){
                          return showDialog(context: context,
                              builder: (context)=>AlertDialog(
                                title: const Text('please confirm'),
                                content: const Text('are you sure ?'),
                                actions: [
                                  TextButton(onPressed: (){Navigator.of(context).pop(true);}, child:const Text(style: TextStyle(color: Colors.black),'yes,delete it!'),),
                                  TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: const Text(style: TextStyle(color: Colors.black),'No ,go back!')) ,
                                ],
                              )
                          );
                        },
                        onDismissed: (DismissDirection direction){
                          provideNotesToUs.deleteNote(currentnote) ;


                        },
                        child: SizedBox.fromSize(
                          size: const Size(250,250),
                          child: GestureDetector(
                            onDoubleTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => ViewNote(note: currentnote,)));
                            },
                            onLongPress: (){Navigator.push(
                                context, MaterialPageRoute(builder: (_) => AddNote(phone:widget.phone ,update:true,NoteForUpdate: currentnote,)));
                            },
                            child: Container(

                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color:const Color.fromARGB(120, 196, 177, 222),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:  const Color(0xFFFFFFFF),
                                    width: 2 ,

                                  )
                              ) ,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentnote.titlef!,
                                      style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20 ),),
                                    const SizedBox(height: 7,),
                                    Text(currentnote.contentf!,
                                      style:  TextStyle(fontSize: 15 , color: Colors.grey[700]),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ): const Center(
                        child: Text('No NoTeS fOuNd'),
                      )
                    ]): const Center(
                  child: Text('add notes',
                    style: TextStyle(fontSize: 20,fontFamily: 'Schyler' ),

                ),

            ),

          ),
        ): const Center(
          child:CircularProgressIndicator(backgroundColor: Colors.black,color: Colors.white,strokeWidth: 4,),
        ),
    );

  }
}
