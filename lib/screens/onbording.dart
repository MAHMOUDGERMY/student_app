import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majles_app/cache/cashe_helper.dart';
import 'package:majles_app/cubit/cubit.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../comp.dart';
import 'home.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  final bool Choose;

  BoardingModel(
      {required this.image,
      required this.title,
      required this.body,
      required this.Choose});
}

var boardController = PageController();

List<BoardingModel> bording = [
  BoardingModel(
      image: 'assets/images/welcome.svg',
      title: 'مرحبا بك ',
      body:
          "يمكنك من خلال التطبيق متابعة اخر الاخبار الخاصة بالجامعة والكلية الخاصة بك",
      Choose: false),
  BoardingModel(
      image: 'assets/images/learn.svg',
      title: 'تعلم',
      body: "يمكنك من خلال التطبيق الحصول على جميع الملفات الخاصة بالمساقات",
      Choose: false),
  BoardingModel(
      image: 'assets/images/start.svg',
      title: 'ابدأ رحلتك الان',
      body: "نتمنى لك التوفيق",
      Choose: true),
];
bool isLast = false;

void submit(context, fac) async {
  await CacheHelper.saveData(key: "fac", value: fac);
  await FirebaseMessaging.instance.subscribeToTopic(fac);
  print(fac);
  print("1231231321315sssssssssssss");

  await CacheHelper.saveData(key: "OnBording", value: true).then((value) {
    if (value) {
      navigateto(context, Home());
      CubitHome.get(context).getData();
    }
  });
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      if (index == bording.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                        print("The last page");
                      } else {
                        print("The not last page");
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    controller: boardController,
                    itemBuilder: (context, index) =>
                        BuildBorditem(bording[index]),
                    itemCount: bording.length,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                        controller: boardController,
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          dotHeight: 10,
                          activeDotColor: Colors.blue,
                          dotWidth: 10,
                          spacing: 10,
                        ),
                        count: bording.length),
                    const Spacer(),
                    if (faculity != '')
                      FloatingActionButton(
                        onPressed: () {
                          if (isLast) {
                            submit(context, faculity);
                          } else {
                            boardController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          }
                        },
                        child: Icon(Icons.arrow_forward_ios),
                      )
                  ],
                )
              ],
            ),
          )),
    );
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
  BuildBorditem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SvgPicture.asset(
              model.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          model.Choose
              ? SelectFormField(
                  type: SelectFormFieldType.dialog, // or can be dialog
                  icon: Icon(Icons.format_shapes),

                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid, color: Colors.white)),
                      prefixIcon: Icon(Icons.arrow_drop_down),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "اختر الكلية",
                      hintText: "الكلية",
                      hintStyle: TextStyle(color: Colors.white)),

                  items: _items,
                  onChanged: (val) {
                    faculity = val;
                    setState(() {});
                  },
                  onSaved: (String? val) => {
                    setState(() {
                      faculity = val!;
                    })
                  },
                )
              : SizedBox(),
        ],
      );
}
