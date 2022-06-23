import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:siksha_anudan/TextFieldWidget.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaymentPage();
  }
}

class _PaymentPage extends State<PaymentPage> {
  String mid = "", orderId = "", amount = "", txnToken = "";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = true;
  @override
  void initState() {
    print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              TextFieldWidget(label: "Merchant ID",text: mid, onChanged: (val) => mid = val,enabled: true,),
              TextFieldWidget(label:'Order ID', text:orderId,enabled:true ,onChanged: (val) => orderId = val),
              TextFieldWidget(label:'Amount', text: amount, enabled: true,onChanged: (val) => amount = val),
              TextFieldWidget(label: 'Transaction Token', text: txnToken,
                  enabled: true,onChanged: (val) => txnToken = val),
              TextFieldWidget(label: 'CallBack URL',text: callbackUrl, enabled: true,onChanged: (val) => callbackUrl = val),
              Row(
                children: <Widget>[
                  Checkbox(
                      activeColor: Theme.of(context).buttonColor,
                      value: isStaging,
                      onChanged: (bool? val) {
                        setState(() {
                          isStaging = val!;
                        });
                      }),
                  const Text("Staging")
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      activeColor: Theme.of(context).buttonColor,
                      value: restrictAppInvoke,
                      onChanged: (bool? val) {
                        setState(() {
                          restrictAppInvoke = val!;
                        });
                      }),
                  const Text("Restrict AppInvoke")
                ],
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: isApiCallInprogress
                      ? null
                      : () {
                    _startTransaction();
                  },
                  child: const Text('Start Transcation'),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: const Text("Message : "),
              ),
              Container(
                child: Text(result),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startTransaction() async {
    if (txnToken.isEmpty) {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke,
      "enableAssist": enableAssist
    };
    print(sendMap);
    try {
      var response = AllInOneSdk.startTransaction(mid, orderId, amount,
          txnToken, callbackUrl, isStaging, restrictAppInvoke, enableAssist);
      response.then((value) {
        print(value);
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = "${onError.message} \n  ${onError.details}";
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.toString();
    }
  }
}