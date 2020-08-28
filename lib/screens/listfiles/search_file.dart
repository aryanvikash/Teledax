import 'package:Teledax/api/Api.dart';
import 'package:Teledax/models/searchmodel.dart';
import 'package:Teledax/screens/common/item_card.dart';
import 'package:flutter/material.dart';

class FileSearch extends SearchDelegate {
  var chatid;

  FileSearch({@required this.chatid});

  @override
  List<Widget> buildActions(BuildContext context) {
    // Clear Text From Search bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Center(
            child: Text(
              "No Data",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        : FutureBuilder(
            future: searchInTg(chatid: chatid.toString(), query: query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data;
                final items = snap.itemList;
                if (items.length < 1) {
                  return Center(
                    child: Text(
                      "Search Not Found",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ItemCard(
                      item: items[index],
                      chatId: chatid,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: Colors.white),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
        child: Text(
      "No recent Search Found",
      style: TextStyle(color: Colors.white, fontSize: 20),
    ));
  }
}

final recentSearch = ["No Recent Data found"];
