import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majles_app/cubit/cubit.dart';
import 'package:majles_app/cubit/state.dart';
import 'package:majles_app/screens/files.dart';
import 'package:majles_app/screens/masaqs.dart';

class Levels extends StatelessWidget {
  final String? part_name;

  const Levels(this.part_name);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHome, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text("المستويات"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Masaqs(
                                      part_name: part_name,
                                      level: "level1",
                                    )));
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "المستوى الاول",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                          )),
                          Icon(Icons.folder),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Masaqs(
                                      part_name: part_name,
                                      level: "level2",
                                    )));
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "المستوى الثاني",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                          )),
                          Icon(Icons.folder),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Masaqs(
                                      part_name: part_name,
                                      level: "level3",
                                    )));
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "المستوى الثالث",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                          )),
                          Icon(Icons.folder),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Masaqs(
                                      part_name: part_name,
                                      level: "level4",
                                    )));
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "المستوى الرابع",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                          )),
                          Icon(Icons.folder),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
