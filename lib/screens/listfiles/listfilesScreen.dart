import 'package:Teledax/api/Api.dart';
import 'package:Teledax/screens/common/item_card.dart';
import 'package:Teledax/screens/listfiles/search_file.dart';
import 'package:Teledax/style/constants.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FilesScreen extends StatefulWidget {
  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: darkcolor,
      appBar: AppBar(
        backgroundColor: darkcolor,
        centerTitle: true,
        title: Text(
          data['chat'].name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: FileSearch(chatid: data['chat'].id.toString()));
              })
        ],
      ),
      body: FutureBuilder(
          future: getFiles(data['chat'].id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final chatitem = snapshot.data;
              final items = chatitem.itemList;

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    item: items[index],
                    chatId: data['chat'].id,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
