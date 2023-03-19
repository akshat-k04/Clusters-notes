import 'dart:io';

import 'package:clusters/common/common_helper.dart';
import 'package:clusters/components/tool_barForDrawing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scribble/scribble.dart';
import 'package:share_plus/share_plus.dart';

class Drawing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawingState();
  }
}

class DrawingState extends State<Drawing> {
  get systemOverlayStyle => null;
  late ScribbleNotifier notifier;
  late ScribbleState state;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notifier = ScribbleNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.grey),
        title: const Text(
          "Draw Your Day",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Schyler'),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              tooltip: "Save to Image",
              onPressed: (){SaveImg(context) ;},
              icon: Icon(Icons.save_alt_rounded))
        ],
      ),
      body: StateNotifierBuilder<ScribbleState>(
      stateNotifier: notifier,
    builder : (context,state,_)=>
      Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: SizedBox(
                height: (MediaQuery.of(context).size.height * 2>MediaQuery.of(context).size.width * 2)?MediaQuery.of(context).size.height * 2:MediaQuery.of(context).size.width * 2,
                width: (MediaQuery.of(context).size.height * 2>MediaQuery.of(context).size.width * 2)?MediaQuery.of(context).size.height * 2:MediaQuery.of(context).size.width * 2,
                child: Scribble(
                  notifier: notifier,
                  drawPen: true,
                ),
              ),
            ),
          ),
          // this widget make the space for drawing
          Positioned(
            top: 16,
            right: 16,
            child:ColorToolBar(notifier: notifier,state: state,),
          ),
          Positioned(
            top: 18.5,
              left: 78,
              child: SizedBox(
                height: 40,
                child: EditToolBar(notifier: notifier,st: state.allowedPointersMode == ScribblePointerMode.penOnly,),
              )
          ),
        ],
      ),
      ),
    );
  }
  void SaveImg(BuildContext context)async{
    final image = await notifier.renderImage();
    final Uint8List pngBytes = image.buffer.asUint8List();
    showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
          title: const Text("Your Image"),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Colors.black
                )
            ),
            child:Image.memory(image.buffer.asUint8List()),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  ShareLocally(pngBytes,Image.memory(image.buffer.asUint8List()));
                  Navigator.of(context).pop(true);
                } ,
                child: const Text('save and Share',style: TextStyle(color: Colors.black),)),
            TextButton(
                onPressed: (){
                  saveLocally(pngBytes);
                  Navigator.of(context).pop(true);
                  } ,
                child: const Text('save it',style: TextStyle(color: Colors.black),))
          ],

      ),
    );
  }

  void ShareLocally(Uint8List pngBytes, Image imge)async{
    //code is same to same as saveLocally
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String nme =DateTime.now().millisecond.toString() ;
    final String fullPath = '$dir/${nme}.png';
    File capturedFile = File(fullPath);
    await capturedFile.writeAsBytes(pngBytes);
    print(capturedFile.path);
    alertDialog(context, 'image saved successfully!');
    await GallerySaver.saveImage(capturedFile.path);
    
    //now the code is different
    await Future.delayed(Duration(milliseconds: 300)) ;
    await Share.shareXFiles([XFile(fullPath)])    ;


  }
  void saveLocally(Uint8List pngBytes)async{
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String fullPath = '$dir/${DateTime.now().millisecond}.png';
    File capturedFile = File(fullPath);
    await capturedFile.writeAsBytes(pngBytes);
    print(capturedFile.path);
    alertDialog(context, 'image saved successfully!');
    await GallerySaver.saveImage(capturedFile.path);

  }
}



