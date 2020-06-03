import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebBrowser extends StatefulWidget {
  var url;

  WebBrowser(this.url);

  @override
  _WebBrowserState createState() => _WebBrowserState(url);
}

class _WebBrowserState extends State<WebBrowser> {
  var url;
  ProgressDialog pd;
  _WebBrowserState(this.url);
@override
  void initState() {
  pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
          child:  WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: ((str){
              pd.show();
            }),
            onPageFinished: ((str){
              pd.dismiss();
            }),
            onWebViewCreated: ((webviewController){
              webviewController.canGoBack().then((value){
                if(value){
                  webviewController.goBack();
                }else{
                  Flushbar(
                    backgroundColor: Colors.red,
                    message: "Can't go back any more",
                    duration: Duration(seconds: 3),
                  )..show(context);
                }
              });
            }),
          ),

        )
    );
  }
}
