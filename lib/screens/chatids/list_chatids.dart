import 'package:Teledax/api/Api.dart';
import 'package:Teledax/models/chatid_model.dart';
import 'package:Teledax/screens/common/custom_appbar.dart';
import 'package:Teledax/style/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatIds extends StatefulWidget {
  @override
  _ChatIdsState createState() => _ChatIdsState();
}

class _ChatIdsState extends State<ChatIds> {
  DateTime currentBackPressTime;

  var data;

  var baseurl;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    baseurl = data["baseurl"];

    return Scaffold(
      backgroundColor: lightColor,
      appBar: customAppbar("Select chat", context),
      body: WillPopScope(child: chatIdList(), onWillPop: onWillPop),
    );
  }

  chatIdList() {
    return FutureBuilder(
      future: getchatid(baseurl: baseurl),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Chatid chatid = snapshot.data;

          return ListView.builder(
            itemCount: chatid.chats.length,
            itemBuilder: (context, index) {
              final item = chatid.chats[index];

              return SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadowColor: Colors.black,
                    color: cardLightColor,
                    child: ListTile(
                      hoverColor: accents,
                      contentPadding: EdgeInsets.all(5.0),
                      leading: CachedNetworkImage(
                        imageUrl: "$baseurl/${item.id}/logo",
                        errorWidget: (context, url, error) =>
                            Image.asset("images/logo.png"),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                      ),
                      title: Text(
                        item.name,
                        style: TextStyle(
                            color: fontColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: SecondaryColor,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/files", arguments: {
                          "chat": item,
                          "baseurl": data['baseurl']
                        });
                      },
                    )),
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
      },
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "press again to exit ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: accents,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
