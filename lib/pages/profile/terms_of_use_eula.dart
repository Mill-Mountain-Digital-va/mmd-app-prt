import 'package:protennisfitness/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUseEULA extends StatefulWidget {
  @override
  _TermsOfUseStateEULA createState() => _TermsOfUseStateEULA();
}

class _TermsOfUseStateEULA extends State<TermsOfUseEULA> {

  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'Terms of Use (EULA)',
          style: appBarTextStyle,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(fixPadding * 2.0),
        child: WebView(
          key: const ValueKey('webviewx'),
          initialUrl: 'https://protennisfitness.com/terms-of-use-eula',
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url){
            print("****** onPageStarted ******");
            print(url);

           
          },
          onProgress: (url){
            // print("****** onProgress ******");
            // print(url);
          },
          onPageFinished: (url){
            print("****** onPageFinished ******");
            print(url);

           
          },
          onWebViewCreated: (controller) {
            _controller = controller;
            // _controller!.loadUrl("https://www.google.pt"
              // Uri.dataFromString(
              //   "www.google.pt",// _con.paymentHtml,
              //   mimeType: 'text/html',
              //   encoding: Encoding.getByName('utf-8'),
              // ).toString(),
            // );

            // Timer.periodic(
            //   Duration(seconds: 2),
            //   (timer) async {
            //     final responsePayment = await _checkPaymentStatus();
            //     if (responsePayment != null) timer.cancel();
            //   },
            // );
          },
        ),
      ),
    );
  }
}
