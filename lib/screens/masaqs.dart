import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majles_app/screens/files.dart';
import 'package:majles_app/screens/levels.dart';

class Masaqs extends StatefulWidget {
  final String? part_name;
  final String? level;

  const Masaqs({this.part_name, this.level});

  @override
  _MasaqsState createState() => _MasaqsState();
}

class _MasaqsState extends State<Masaqs> {
  List masaqs = [];

  @override
  void initState() {
    FirebaseStorage.instance
        .ref("It/${widget.part_name}/${widget.level}")
        .listAll()
        .then((value) {
      value.prefixes.forEach((element) {
        setState(() {
          masaqs.add(element.name);
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
              title: Text("المساقات"),
            ),
            body: masaqs.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            buildMassaqitem(masaqs[index]),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: masaqs.length))
                : Center(child: CircularProgressIndicator())));
  }

  buildMassaqitem(String Massaq) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Files(
                      masaq_name: Massaq,
                      level: widget.level,
                      part_names: widget.part_name,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                Massaq,
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
