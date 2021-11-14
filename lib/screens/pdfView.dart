import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:majles_app/comp.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFVIEW extends StatefulWidget {
  final Map<String, dynamic> file;

  const PDFVIEW(this.file);

  @override
  _PDFVIEWState createState() => _PDFVIEWState();
}

class _PDFVIEWState extends State<PDFVIEW> {
  String path = '';
  initDownloadsDirectoryState() async {
    Directory downloadsDirectory;
    // Platform messages may fail, so we use a try/catch PlatformException.

    downloadsDirectory = (await DownloadsPathProvider.downloadsDirectory)!;
    path = downloadsDirectory.path;
    print(path);
  }

  double? progressa;
  download() async {
    final downloaderUtils = DownloaderUtils(
      progressCallback: (current, total) {
        final progress = (current / total) * 100;
        setState(() {
          progressa = progress;
        });
        print('Downloading: $progress');
      },
      file: File('$path/${widget.file["name"]}'),
      progress: ProgressImplementation(),
      onDone: () {
        progressa = null;
        ShowToast(msg: "تم تحميل الملف", color: Colors.green);
      },
      deleteOnCancel: true,
    );

    final core =
        await Flowder.download('${widget.file["url"]}', downloaderUtils);
  }

  @override
  void initState() {
    initDownloadsDirectoryState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.file["name"]}"),
          actions: [
            progressa == null
                ? IconButton(
                    onPressed: () {
                      download();
                    },
                    icon: Icon(Icons.download))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("${progressa!.toInt()}%")),
                  )
          ],
        ),
        body: SfPdfViewer.network(
          widget.file['url'],
          canShowPaginationDialog: true,
        ));
  }
}
