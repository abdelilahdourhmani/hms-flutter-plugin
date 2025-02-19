/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_fido/huawei_fido.dart';
import 'package:huawei_fido_example/widgets/custom_button.dart';

class BioAuthnPromptExample extends StatefulWidget {
  @override
  _BioAuthnPromptExampleState createState() => _BioAuthnPromptExampleState();
}

class _BioAuthnPromptExampleState extends State<BioAuthnPromptExample> {
  late HmsBioAuthnPrompt prompt;
  List<String> _results = ["Results will be listed here"];

  @override
  void initState() {
    prompt = new HmsBioAuthnPrompt();
    prompt.setCallback((event, {errCode, result}) {
      _updateList("Auth event: " + describeEnum(event!));
    });
    super.initState();
  }

  _init() async {
    HmsBioAuthnPromptInfo info = new HmsBioAuthnPromptInfo(
        title: "Authentication",
        subtitle: "Verify your id",
        description: "Confirm this is you",
        deviceCredentialAllowed: false);

    try {
      bool? result = await prompt.configurePrompt(info);
      _updateList("Configured: $result");
    } on Exception catch (e) {
      _updateList(e.toString());
    }
  }

  _authWithoutCryptoObject() async {
    try {
      await prompt.authenticateWithoutCryptoObject();
    } on Exception catch (e) {
      _updateList(e.toString());
    }
  }

  _authWithCryptoObject() async {
    HmsCipherFactory factory = new HmsCipherFactory();
    factory.storeKey = "hw_test_fingerprint";
    factory.password = "12psw456.";
    factory.userAuthenticationRequired = true;

    try {
      await prompt.authenticateWithCryptoObject(factory);
    } on Exception catch (e) {
      _updateList(e.toString());
    }
  }

  _cancelAuth() async {
    try {
      bool? res = await prompt.cancelAuth();
      _updateList("Auth canceled: $res");
    } on Exception catch (e) {
      _updateList(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Authn Prompt Example")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customButton("Configure", _init),
          customButton("Auth Without Crypto Object", _authWithoutCryptoObject),
          customButton("Auth With Crypto Object", _authWithCryptoObject),
          customButton("Cancel Auth", _cancelAuth),
          Expanded(
              child: GestureDetector(
            onDoubleTap: () {
              setState(() => _results.clear());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey)),
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (ctx, index) {
                  return Text(_results[index]);
                },
              ),
            ),
          ))
        ],
      ),
    );
  }

  _updateList(String obj) {
    setState(() => _results.add(obj));
  }
}
