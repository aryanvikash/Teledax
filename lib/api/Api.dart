import 'dart:developer';

import 'package:Teledax/models/chatItems_model.dart';
import 'package:Teledax/models/chatid_model.dart';
import 'package:Teledax/models/searchmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//
// const baseurl = "https://teledax.aryanvikash.com";

Future<Chatid> getchatid({baseurl}) async {
  try {
    final response = await http.get(Uri.encodeFull(baseurl));

    //only accept json response
    if (response.headers['content-type'] != "application/json; charset=utf-8") {
      throw Exception("response is not application/json; charset=utf-8");
    }
    if (response.statusCode == 200) {
      return chatidFromJson(response.body);
    } else {
      throw 'Failed to Load Data';
    }
  } catch (e) {
    throw e;
  }
}

Future getFiles({chatid, baseurl}) async {
  log('$baseurl/$chatid');
  try {
    final response = await http.get('$baseurl/$chatid');

    if (response.headers['content-type'] != "application/json; charset=utf-8") {
      throw Exception("response is not application/json; charset=utf-8");
    }

    if (response.statusCode == 200) {
      final chatitems = chatItemsFromJson(response.body);

      return chatitems;
    } else {
      throw Exception('Failed to Load Data');
    }
  } catch (e) {
    log("Error While Chatitems $e");
    throw e;
  }
}

// Fetch next page
// ?page=2
Future getNextPage(nextpageurl) async {
  try {
    final response = await http.get(nextpageurl);

    if (response.headers['content-type'] != "application/json; charset=utf-8") {
      throw Exception("response is not application/json; charset=utf-8");
    }

    if (response.statusCode == 200) {
      final nextpageItem = chatItemsFromJson(response.body);

      return nextpageItem;
    } else {
      throw Exception('Failed to Load Data');
    }
  } catch (e) {
    log("Error While Chatitems $e");
    throw e;
  }
}

Future<SearchItem> searchInTg(
    {@required chatid, @required query, @required baseurl}) async {
  try {
    final response = await http.get('$baseurl/$chatid?search=$query');
    log('$baseurl/$chatid?search=$query');
    if (response.statusCode == 200) {
      SearchItem searchItem = searchItemFromJson(response.body);

      return searchItem;
    } else {
      throw Exception('Failed to Load Data');
    }
  } catch (e) {
    log("Error While searching $e");
    throw e;
  }
}
