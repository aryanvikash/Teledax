import 'package:Teledax/api/Api.dart';
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
  var baseurl;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    baseurl = data["baseurl"];
    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        backgroundColor: lightColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          data['chat'].name,
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
                        chatid: data['chat'].id.toString(), baseurl: baseurl));
              })
        ],
      ),
      body: FutureBuilder(
          future: getFiles(chatid: data['chat'].id, baseurl: baseurl),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final chatitem = snapshot.data;
              final items = chatitem.itemList;

              return ListView.builder(
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
            } else if (snapshot.hasError) {
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
