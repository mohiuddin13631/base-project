import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class WithDrawForm {
  Form({List<WithdrawFormModel>? list}) {
    _list = list;
  }

  List<WithdrawFormModel>? _list = [];

  List<WithdrawFormModel>? get list => _list;

  WithDrawForm.fromJson(dynamic json) {

    print("json --------- ");

    print(json);

    var map = Map.from(json).map((k, v) => MapEntry<String, dynamic>(k, v));
    // var map = Map.from(json).map((k, v) {
    //   print("key : ${k} : value : ${v}\n");
    //   return MapEntry<String, dynamic>(k, v);
    // });

    print("map ------------- :");
    print(map);

    try {
      List<WithdrawFormModel>? list = map.entries
          .map((e) {

            print("entries -------- :");
            print(e.value);

            return WithdrawFormModel(e.value['name'], e.value['label'], e.value['is_required'], e.value['instruction'], e.value['extensions'], (e.value['options'] as List).map((e) => e as String).toList(), e.value['type'], '');
      },
      ).toList();

      print("list");

      if (list.isNotEmpty) {
        list.removeWhere((element) => element.toString().isEmpty);
        _list?.addAll(list);
      }
      _list;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}


class WithdrawFormModel {
  String? name;
  String? label;
  String? isRequired;
  String? instruction;
  String? extensions;
  List<String>? options;
  String? type;
  dynamic selectedValue;
  TextEditingController? textEditingController;
  File? file;
  List<String>? cbSelected;
  // Added an optional parameter to initialize the textEditingController
  WithdrawFormModel(this.name, this.label, this.isRequired, this.instruction, this.extensions, this.options, this.type, this.selectedValue, {this.cbSelected, this.file, this.textEditingController}) {
    // Initialize textEditingController if not provided
    textEditingController ??= TextEditingController();
  }
}