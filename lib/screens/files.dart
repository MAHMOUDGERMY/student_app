import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majles_app/cubit/state.dart';
import 'package:majles_app/screens/pdfView.dart';

class Files extends StatefulWidget {
  final String? part_names;
  final String? level;
  final String? masaq_name;

  const Files({this.part_names, this.level, this.masaq_name});

  @override
  _PartsState createState() => _PartsState();
}

class _PartsState extends State<Files> {
  List Masaqs = [];
  @override
  void initState() {
    FirebaseStorage.instance
        .ref("It/${widget.part_names}/${widget.level}/${widget.masaq_name}")
        .listAll()
        .then((value) {
      value.items.forEach((element) {
        element.getDownloadURL().then((value) {
          setState(() {
            Masaqs.add({"name": element.name, "url": value.toString()});
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("ملفات المساق"),
        ),
        body: Masaqs.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    itemBuilder: (context, index) => BuildFile(index),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: Masaqs.length),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  BuildFile(index) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PDFVIEW(Masaqs[index])));
      },
      child: Row(
        children: [
          Expanded(child: Text("${Masaqs[index]["name"]}")),
          Icon(Icons.document_scanner_outlined),
        ],
      ),
    );
  }
}
