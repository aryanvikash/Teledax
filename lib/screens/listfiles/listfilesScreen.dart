import 'dart:developer';

import 'package:Teledax/api/Api.dart';
import 'package:Teledax/models/chatItems_model.dart';
import 'package:Teledax/screens/common/item_card.dart';
import 'package:Teledax/screens/listfiles/search_file.dart';
import 'package:Teledax/style/constants.dart';
import 'package:flutter/material.dart';

class FilesScreen extends StatefulWidget {
  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  Map<String, dynamic> data = {};
  int _nextpageno = 0;
  bool _isnext = false;
  List<ItemList> items = [];
  var baseurl;
  ScrollController _paginationctr = new ScrollController();

  @override
  void initState() {
    _paginationctr.addListener(() {
      if (_paginationctr.position.pixels ==
          _paginationctr.position.maxScrollExtent) {
        print("fectch again");
        _getNext();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      data = ModalRoute.of(context).settings.arguments;
      baseurl = data["baseurl"];
      _getFiles();
    });

    super.initState();
  }

  @override
  void dispose() {
    _paginationctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColor,
        appBar: AppBar(
          backgroundColor: lightColor,
          centerTitle: true,
          elevation: 0,
          title: Text(
            data['chat'] != null ? data['chat'].name : "loading",
            style: TextStyle(
              color: fontColor,
              fontSize: 15,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: fontColor,
                ),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: FileSearch(
                          chatid: data['chat'].id.toString(),
                          baseurl: baseurl));
                })
          ],
        ),
        body: items.length > 0
            ? _list(items)
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  _getFiles() async {
    print("Data: $data");
    ChatItems chatitem =
        await getFiles(chatid: data['chat'].id, baseurl: baseurl);
    items = chatitem.itemList;
    print(chatitem.nextPage);
    setState(() {
      if (chatitem.nextPage != false) {
        _isnext = true;
        _nextpageno = chatitem.nextPage["no"];
      }
    });
  }

  _getNext() async {
    if (!_isnext) {
      print("don't have data lol");
      return;
    }
    _isnext = false;
    print(items.length);
    ChatItems nextitem =
        await getNextPage("$baseurl/${data['chat'].id}?page=$_nextpageno");
    items.addAll(nextitem.itemList);
    print(items.length);
    setState(() {
      if (nextitem.nextPage != false) {
        _isnext = true;
        _nextpageno = nextitem.nextPage["no"];
      }
    });
  }

  _list(items) {
    // items = chatitem.itemList
    return ListView.builder(
      controller: _paginationctr,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(4),
          child: Card(
            elevation: 2,
            child: ItemCard(
              item: items[index],
              chatId: data['chat'].id,
              baseurl: baseurl,
            ),
          ),
        );
      },
    );
  }

  _errorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
              height: 100,
              width: 100,
              child: Image.asset("images/not-found.png")),
        ),
        Text("Something went wrong"),
      ],
    );
  }
}
