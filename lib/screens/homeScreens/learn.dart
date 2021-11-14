import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majles_app/cubit/cubit.dart';
import 'package:majles_app/cubit/state.dart';

import 'package:majles_app/screens/files.dart';
import 'package:majles_app/screens/levels.dart';
import 'package:majles_app/screens/masaqs.dart';
import 'package:path_provider/path_provider.dart';

import '../pdfView.dart';

class Learn extends StatefulWidget {
  @override
  LearnState createState() => LearnState();
}

class LearnState extends State<Learn> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHome, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildCollegeitem("${CubitHome.get(context).parts[index]}"),
              separatorBuilder: (context, index) {
                return index == CubitHome.get(context).parts.length - 1
                    ? Divider(
                        color: Colors.red,
                      )
                    : Divider(
                        color: Colors.white,
                      );
              },
              itemCount: CubitHome.get(context).parts.length)),
    );
  }

  buildCollegeitem(String part_name) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Levels(part_name)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                part_name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.file_present)
          ],
        ),
      ),
    );
  }
}
