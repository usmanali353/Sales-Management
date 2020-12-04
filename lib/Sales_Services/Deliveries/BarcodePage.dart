import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
class BarcodePage extends StatefulWidget {
  @override
  _BarcodePageState createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  GlobalKey globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode"),
      ),
      body:Center(
        child:Container(
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 150,
                child: RepaintBoundary(
                  key: globalKey,
                  child: SfBarcodeGenerator(
                    value: 'PKL20-012722',
                    symbology: Code128(),
                    showValue: true,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              RaisedButton.icon(color: Color(0xFF004c4c),onPressed: () async {
                final doc = pw.Document();
                RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
                var image = await boundary.toImage();
                ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
                Uint8List pngBytes = byteData.buffer.asUint8List();
                final PdfImage img = await pdfImageFromImageProvider(pdf: doc.document, image: MemoryImage(pngBytes));
                final PdfImage imgLogo = await pdfImageFromImageProvider(pdf: doc.document, image: AssetImage("assets/img/AC.png"));
                doc.addPage(pw.Page(
                    build: (pw.Context context) {
                      return pw.Column(
                          children: [
                            pw.Center(
                                child: pw.Image(imgLogo,width: 150,height:150)
                            ),
                            pw.Padding(padding: pw.EdgeInsets.all(8.0)),
                            pw.Center(
                                child: pw.Image(img,width: 300,height:350)
                            ),
                            pw.Padding(padding: pw.EdgeInsets.all(8.0)),
                            pw.Center(
                                child: pw.Text("Please Scan this Barcode to get Details of Delivery",style: pw.TextStyle(fontSize: 15))
                            ),
                          ]
                      );
                    })); // Pa
                await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async => doc.save());
              },icon:Icon(Icons.print,color: Colors.white,), label: Text("Print",style: TextStyle(color: Colors.white),),)
            ],
          ),
        )
      )
    );
  }
}
