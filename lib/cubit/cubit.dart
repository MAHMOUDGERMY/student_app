import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:majles_app/SendNoty.dart';
import 'package:majles_app/cache/cashe_helper.dart';
import 'package:majles_app/comp.dart';
import 'package:majles_app/cubit/state.dart';
import 'package:majles_app/screens/homeScreens/contact.dart';
import 'package:majles_app/screens/homeScreens/feed.dart';
import 'package:majles_app/screens/homeScreens/learn.dart';
import 'package:majles_app/screens/homeScreens/profile.dart';
import 'package:majles_app/screens/levels.dart';
import 'package:http/http.dart' as http;

class CubitHome extends Cubit<HomeState> {
  CubitHome() : super(InitialState());

  static CubitHome get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [Feed(), Learn(), Contact(), Profile()];
  List<dynamic> titles = [
    "Home",
    "Learn",
    "Contact",
    "Profile",
  ];

  void ChangeNav(int index) {
    currentIndex = index;
    emit(changeNavState());
  }

  var a = [
    {
      "name": "multi",
      "levels": [
        {
          "level1": {
            "masaqs": [
              {
                "name": "web1",
                "files": [
                  {"name": "programe1", "url": "url"}
                ]
              }
            ]
          }
        },
      ]
    }
  ];

  List parts = [];

  Future<void> getData() async {
    parts = [];
    emit(getFilesLoading());

    var fac = await CacheHelper.getData(key: "fac");
    faculity_name = fac;

    await FirebaseStorage.instance.ref(fac).listAll().then((value) {
      value.prefixes.forEach((part) async {
        parts.add(part.name);
      });
    }).then((value) {
      emit(getFilesSuccess());
    }).catchError((onError) {
      emit(getFilesError());
    });
  }

  File? postImage;
  var picker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);

      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedErrorState());
    }
  }

  void uploadpostImage({required String text, required String dateTime}) {
    emit(PostAddLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        addPost(text: text, dateTime: dateTime, Image: value);
      }).catchError((error) {
        emit(PostAddErrorsState());
      });
    }).catchError((error) {
      emit(PostAddErrorsState());
    });
  }

  void addPost(
      {required String text, required String dateTime, String? Image}) async {
    emit(PostAddLoadingState());
    FirebaseFirestore.instance
        .collection("posts")
        .add({"text": text, "dateTime": dateTime, "image": Image ?? ''}).then(
            (value) {
      ShowToast(msg: "تم اضافة البوست", color: Colors.green);
      getPosts();

      emit(PostAddSuccessState());
    });
  }

  void removeImagePost() {
    postImage = null;
    emit(RemovePostImage());
  }

  List<Map> posts = [];

  Future getPosts() {
    emit(GetPostsLoadingState());
    posts = [];
    return FirebaseFirestore.instance
        .collection("posts")
        .orderBy("dateTime")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        posts.add(element.data());
      });
      emit(GetPostsSuccessState());
    }).catchError((onError) {
      emit(GetPostsErrorState());
    });
  }

  UserCredential? user;

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      return await FirebaseFirestore.instance
          .collection("users")
          .doc(value.user!.uid)
          .update({
        "name": value.user!.displayName,
        "Uid": value.user!.uid,
      });
    }).then((value) {
      emit(userLogin());
    });
  }

  String? isAdmin;
  Future getUserData() async {
    if (FirebaseAuth.instance.currentUser != null)
      return FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        isAdmin = event.data()!["Admin"];
        emit(GetUserState());
      });
  }

  Future SignOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      emit(userLogout());
    });
  }

  void sendNoty({String fac = "all", title, text}) async {
    print(fac);
    await DioHelper.postData(url: "https://fcm.googleapis.com/fcm/send", data: {
      "to": "topics/$fac",
      "notification": {"title": title, "body": text, "sound": "default"},
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": false,
          "default_vibrate_timing": true,
          "default_light_setting": true
        }
      },
    });
  }

  send({String fac = "all", String? title, String? text}) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAX3xyBcE:APA91bEvEozUyCVYW2mLkB7FkC6l-VfHXCJcTcpDdl7Aiyly1_3b8tmrLqc_yLA2eVzRk8_jQfAIY-qd2P3In62Tqu6KsS12nbgq1J8gkUbzRu48jaPnSNCZIoijOQbZJAWYjYVhjOBm',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': text, 'title': title},
          'priority': 'high',
          'to': "/topics/$fac",
        },
      ),
    );
  }
}
