import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mytutor/constant.dart';
import 'package:mytutor/model/user.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentSc extends StatefulWidget {
  final User user;
  final double totalpayable;

  const PaymentSc({Key? key, required this.user, required this.totalpayable})
      : super(key: key);

  @override
  State<PaymentSc> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentSc> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl: CONSTANTS.server +
                    '/276984/mytutor/php/payment.php?email=' +
                    widget.user.email.toString() +
                    '&mobile=' +
                    widget.user.phone.toString() +
                    '&name=' +
                    widget.user.name.toString() +
                    '&amount=' +
                    widget.totalpayable.toString(),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            )
          ],
        ));
  }
}
