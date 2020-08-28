import 'package:Teledax/api/Api.dart';
import 'package:Teledax/models/chatid_model.dart';

import 'package:Teledax/style/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkcolor,
      appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                MdiIcons.information,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, "/devs"),
            )
          ],
          title: Text("Select Chat"),
          centerTitle: true,
          backgroundColor: darkcolor),
      body: chatIdList(),
    );
  }
}

Widget chatIdList() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: FutureBuilder(
      future: getchatid(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Chatid chatid = snapshot.data;
          return ListView.builder(
            itemCount: chatid.chats.length,
            itemBuilder: (context, index) {
              final item = chatid.chats[index];

              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Card(
                    elevation: 15,
                    color: darkCardColor,
                    child: InkWell(
                      splashColor: accents,
                      onTap: () => null,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        leading: CachedNetworkImage(
                          imageUrl: "$baseurl/${item.id}/logo",
                          errorWidget: (context, url, error) =>
                              Image.asset("images/logo.png"),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                        ),
                        title: Text(
                          item.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.amberAccent,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/files",
                              arguments: {"chat": item});
                        },
                      ),
                    )),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.redAccent, fontSize: 20),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
  );
}
