import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlay = false;
  String duration ="00:00";
  String position ="00:00";

  @override
  void initState() {
    super.initState();
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration=event.toString().split(".")[0];
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position=event.toString().split(".")[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        child: Icon(
          Icons.audiotrack
        ),
        onPressed: () async{
          FilePickerResult result =await FilePicker.platform.pickFiles();
          if(result != null){
            int status = await audioPlayer.play(result.files.single.path,isLocal: true);
            if(status == 1){
              setState(() {
                isPlay = true;
              });
            }
          }
        },
      ),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xfff8f8f8),
        title: Text(
          "Music player",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                            image: AssetImage("images/dog.jpg"),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "songs",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Singer : Shafika",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: 80,
                      width: 300,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                           icon: Icon(
                               isPlay == false ? Icons.play_arrow : Icons.pause,
                             // Stop Video After Start
                             size: 35,
                           ),
                            onPressed: (){
                             if(isPlay == true){
                               audioPlayer.pause();
                               setState(() {
                                 isPlay = false;
                               });
                             }else{
                               audioPlayer.resume();
                               setState(() {
                                 isPlay = true;
                               });
                             }
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.stop,
                              size: 35,
                            ),
                            onPressed: (){
                              audioPlayer.stop();
                              setState(() {
                                isPlay = true;
                              });
                            },
                          ),
                          Container(
                            width: 130,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    duration,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text("|",),
                                Text(
                                  position,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
