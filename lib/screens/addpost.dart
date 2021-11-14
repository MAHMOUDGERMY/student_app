import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majles_app/cache/cashe_helper.dart';
import 'package:majles_app/comp.dart';
import 'package:majles_app/cubit/cubit.dart';
import 'package:majles_app/cubit/state.dart';
import 'package:select_form_field/select_form_field.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var textCon = TextEditingController();
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'teb',
      'label': 'الطب',
      'icon': Icon(Icons.medical_services),
    },
    {
      'value': 'tamrid',
      'label': 'التمريض',
      'icon': Icon(Icons.medication_outlined),
    },
    {
      'value': 'It',
      'label': 'تكنولوجيا المعلومات',
      'icon': Icon(Icons.computer_rounded),
    },
    {
      'value': 'tarbia',
      'label': 'التربية',
      'icon': Icon(Icons.cabin),
    },
    {
      'value': 'kanonandsharia',
      'label': 'الشريعة والقانون',
      'icon': Icon(Icons.brightness_low_sharp),
    },
    {
      'value': 'asolaldin',
      'label': 'اصول الدين',
      'icon': Icon(Icons.grade),
    },
    {
      'value': 'sahafa',
      'label': 'الصحافة والاعلام',
      'icon': Icon(Icons.camera_alt),
    },
  ];
  String faculity = 'all';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHome, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(title: Text("Create Post"), actions: [
                TextButton(
                  child: Text(
                    "POST",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.deepOrange),
                  ),
                  onPressed: () {
                    if (textCon.text != "" ||
                        CubitHome.get(context).postImage != null) {
                      if (CubitHome.get(context).postImage == null) {
                        CubitHome.get(context).addPost(
                          text: textCon.text,
                          dateTime: DateTime.now().toString(),
                        );
                        CubitHome.get(context).send(
                          fac: faculity,
                          text: textCon.text,
                          title: "مجلس الطلاب",
                        );
                      } else {
                        CubitHome.get(context).send(
                          fac: faculity,
                          text: textCon.text,
                          title: "مجلس الطلاب",
                        );
                        CubitHome.get(context).uploadpostImage(
                            dateTime: DateTime.now().toString(),
                            text: textCon.text);
                      }
                    }
                  },
                )
              ]),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (state is PostAddLoadingState)
                      LinearProgressIndicator(
                        color: Colors.red,
                        backgroundColor: Colors.green,
                      ),
                    if (state is PostAddLoadingState)
                      SizedBox(
                        height: 5,
                      ),
                    Row(children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://img.freepik.com/free-photo/mand-holding-cup_1258-340.jpg?size=338&ext=jpg"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          "Majles",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      )
                    ]),
                    Expanded(
                      child: TextFormField(
                        controller: textCon,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "can not be empty";
                          }
                        },
                        style: TextStyle(color: Theme.of(context).canvasColor),
                        decoration: InputDecoration(
                            hintText: "what is on your mind ....",
                            hintStyle: Theme.of(context).textTheme.caption,
                            border: InputBorder.none),
                      ),
                    ),
                    SelectFormField(
                      type: SelectFormFieldType.dialog, // or can be dialog
                      icon: Icon(Icons.format_shapes),

                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.white)),
                          prefixIcon: Icon(Icons.arrow_drop_down),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "اختر الكلية",
                          hintText: "الكلية",
                          hintStyle: TextStyle(color: Colors.white)),

                      items: _items,
                      onChanged: (val) async {
                        faculity = val;
                      },

                      onSaved: (val) => faculity = val!,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (CubitHome.get(context).postImage != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                image: FileImage(
                                    CubitHome.get(context).postImage!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                  onPressed: () {
                                    CubitHome.get(context).removeImagePost();
                                  },
                                  icon: Icon(Icons.close)),
                            ),
                          )
                        ],
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                CubitHome.get(context).getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("add Photo")
                                ],
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        });
  }
}
