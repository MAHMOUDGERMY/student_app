import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majles_app/cubit/cubit.dart';
import 'package:majles_app/cubit/state.dart';
import 'package:path_provider/path_provider.dart';

import '../pdfView.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHome, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Text("${index + 1}"),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
              itemCount: 20),
        );
      },
    );
  }
}
