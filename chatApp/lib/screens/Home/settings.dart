import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screens/Home/Home.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/shared/constants.dart';
import 'package:chatapp/screens/Authenticate/helperfuncs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

// import 'package:image_crop/image_crop.dart';
import 'dart:io';

class Settings1 extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings1> {
  DatabaseServices databaseService = new DatabaseServices();
  QuerySnapshot imagesnapshot;
  bool up = false;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    imagesnapshot = await databaseService.getProfPic(Constants.MyName);
    Constants.MyProfPic = imagesnapshot.docs[0].get('profpic');
    print("pic ${Constants.MyProfPic}");
  }

  initialValue(val) {
    return TextEditingController(text: val);
  }

  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    setState(() {
      try {
        _image = File(pickedFile.path);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    var firebasestorageRef =
        FirebaseStorage.instance.ref().child('Profilepics/$fileName');
    var uploadTask = firebasestorageRef.putFile(_image);
    var taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    databaseService.uploadUserProfilePic(Constants.MyName, downloadUrl);

    setState(() {
      Constants.MyProfPic = downloadUrl;
      print("prof pic uploaded");
      print(Constants.MyProfPic);
      up = true;
      final snackBar = SnackBar(
        content: Text('Yay! A SnackBar!'),
        // action: SnackBarAction(
        //     label: 'Undo',
        //     onPressed: () {
        //       // Some code to undo the change.
        //     })
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Profile'),
          centerTitle: false,
        ),
        body: Container(
            padding: EdgeInsets.only(
                top: 70, left: MediaQuery.of(context).size.width * 0.04),
            width: MediaQuery.of(context).size.width,
            // color: Colors.black87,
            child: Column(
              children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Number of users rated : ",
                //       style: TextStyle(color: Colors.white, fontSize: 20),
                //     ),
                //     Text(
                //       "5",
                //       style: TextStyle(color: Colors.white, fontSize: 20),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage("assets/profPic.jpg"),
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: (_image == null)
                                  ? (Constants.MyProfPic != ""
                                      ? NetworkImage(Constants.MyProfPic)
                                      : AssetImage("assets/profPic.jpg"))
                                  : FileImage(
                                      _image,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(15.0),
                      //   child: GestureDetector(
                      //     child: Icon(
                      //       Icons.edit,
                      //       color: Colors.grey,
                      //       size: 35,
                      //     ),

                      //   ),
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(16),
                            side:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        child: Text(
                          'Discard',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(16),
                            side:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        child: Text(
                          'Upload',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          uploadPic(context);
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Name:',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Text(
                        Constants.MyName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            letterSpacing: 1,
                            wordSpacing: 3),
                      ),
                    ),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rating : ",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    Text(
                      "5" + "/5",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    )
                  ],
                ),
              ],
              // Scaffold.of(context).showSnackBar(snackBar);
            )));
  }
}
