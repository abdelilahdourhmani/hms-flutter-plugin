/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final void Function(String?)? onChanged;
  final List<String>? list;
  final String? label;

  CustomDropdown({Key? key, this.label, this.value, this.onChanged, this.list});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label ?? '',
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black38,
            ),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 1,
              color: Colors.black38,
            ),
            onChanged: onChanged,
            items: list?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
