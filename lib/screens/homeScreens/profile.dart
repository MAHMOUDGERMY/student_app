import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Profile extends StatefulWidget {
  @override
  State createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download File"),
        backgroundColor: Colors.pink,
      ),
      body: null,
    );
  }
}
