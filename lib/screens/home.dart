import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:majles_app/cache/cashe_helper.dart';
import 'package:majles_app/comp.dart';
import 'package:majles_app/cubit/cubit.dart';
import 'package:majles_app/cubit/state.dart';
import 'package:majles_app/screens/addpost.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:select_form_field/select_form_field.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await CubitHome.get(context).getPosts();
    await CubitHome.get(context).getUserData();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

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
      'icon': Icon(Icons.grade),
    },
  ];
  String faculity = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHome, HomeState>(
        listener: (context, state) {},
        builder: (context, state) => Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "${CubitHome.get(context).titles[CubitHome.get(context).currentIndex]}",
                  ),
                ),
                body: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  header: WaterDropHeader(),
                  child: CubitHome.get(context)
                      .screens[CubitHome.get(context).currentIndex],
                ),
                bottomNavigationBar: GNav(
                    // tab button hover color
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    activeColor: Colors.black,
                    iconSize: 24,
                    gap: 20,
                    tabActiveBorder: Border.all(color: Colors.black),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 500),
                    tabBackgroundColor: Colors.white,
                    color: Colors.black, // navigation bar padding
                    onTabChange: (index) =>
                        CubitHome.get(context).ChangeNav(index),
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: 'feed',
                        iconColor: Theme.of(context).iconTheme.color,
                      ),
                      GButton(
                        icon: Icons.book_sharp,
                        iconColor: Theme.of(context).iconTheme.color,
                        text: 'Learn',
                      ),
                      GButton(
                        icon: Icons.mobile_friendly,
                        iconColor: Theme.of(context).iconTheme.color,
                        text: 'Contact',
                      ),
                    ]),
                drawer: Drawer(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: HexColor("333739"),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    height: 400,
                                    child: Column(
                                      children: [
                                        SelectFormField(
                                          type: SelectFormFieldType
                                              .dialog, // or can be dialog
                                          icon: Icon(Icons.format_shapes),

                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: Colors.white)),
                                              prefixIcon:
                                                  Icon(Icons.arrow_drop_down),
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              labelText: "اختر الكلية",
                                              hintText: "الكلية",
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),

                                          items: _items,
                                          onChanged: (val) async {
                                            await FirebaseMessaging.instance
                                                .unsubscribeFromTopic(
                                                    faculity_name);
                                            await FirebaseMessaging.instance
                                                .subscribeToTopic(val);
                                            faculity = val;
                                            await CacheHelper.saveData(
                                                key: "fac", value: faculity);
                                            await CubitHome.get(context)
                                                .getData();

                                            Navigator.pop(context);
                                          },

                                          onSaved: (val) => faculity = val!,
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          title: Text("تغيير الكلية"),
                          leading: Icon(
                            Icons.view_sidebar_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        ListTile(
                          title: Text("رؤية مجلس الطلاب"),
                          leading: Icon(
                            Icons.view_sidebar_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        ListTile(
                          title: Text("رؤية النادي التكنولوجي"),
                          leading: Icon(
                            Icons.view_sidebar_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        ListTile(
                          title: Text("رؤية مجلس الطلاب"),
                          leading: Icon(
                            Icons.view_sidebar_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        ListTile(
                          title: Text("رؤية مجلس الطلاب"),
                          leading: Icon(
                            Icons.view_sidebar_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        ListTile(
                          title: Text("رؤية مجلس الطلاب"),
                          leading: Icon(
                            Icons.view_sidebar_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: Icon(
                              FirebaseAuth.instance.currentUser == null
                                  ? Icons.login
                                  : Icons.logout,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onTap: () async {
                              FirebaseAuth.instance.currentUser == null
                                  ? await CubitHome.get(context)
                                      .signInWithGoogle()
                                  : await CubitHome.get(context).SignOut();
                            },
                            title: FirebaseAuth.instance.currentUser == null
                                ? Text("تسجيل الدخول")
                                : Text("تسجيل الخروج"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: admin(context))));
  }

  admin(BuildContext context) {
    if (FirebaseAuth.instance.currentUser !=
        null) if (CubitHome.get(context).isAdmin == "true") {
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostScreen()));
        },
      );
    }

    return null;
  }
}
