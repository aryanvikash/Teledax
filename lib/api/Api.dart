import 'package:Teledax/models/chatItems_model.dart';
import 'package:Teledax/models/chatid_model.dart';
import 'package:Teledax/models/searchmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseurl = "https://teledax.aryanvikash.com";

Future<Chatid> getchatid() async {
  try {
    final response = await http.get(Uri.encodeFull(baseurl));
    if (response.statusCode == 200) {
      return chatidFromJson(response.body);
    } else {
      throw Exception('Failed to Load Data');
    }
  } catch (e) {
    throw e;
  }
}

Future getFiles(chatid) async {
  print('$baseurl/$chatid');
  try {
    final response = await http.get('$baseurl/$chatid');

    if (response.statusCode == 200) {
      final chatitems = chatItemsFromJson(response.body);

      return chatitems;
    } else {
      throw Exception('Failed to Load Data');
    }
  } catch (e) {
    print("Error While Chatitems $e");
    throw e;
  }
}

Future<SearchItem> searchInTg({@required chatid, @required query}) async {
  try {
    final response = await http.get('$baseurl/$chatid?search=$query');
    print('$baseurl/$chatid?search=$query');
    if (response.statusCode == 200) {
      SearchItem searchItem = searchItemFromJson(response.body);

      return searchItem;
    } else {
      throw Exception('Failed to Load Data');
    }
  } catch (e) {
    print("Error While searching $e");
    throw e;
  }
}
